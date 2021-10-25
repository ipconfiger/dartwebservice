import 'package:xml/xml.dart';

class Type {
  String name;
  Map<String, String> prototypes;
  Type(this.name, this.prototypes);
}

class MessagePart {
  String name;
  String typeName;
  bool isComplex;
  MessagePart(this.name);
}

class Message {
  String name;
  List<MessagePart> parts;
  Message(this.name) {
    this.parts = new List<MessagePart>();
  }
}

class Parameter {
  String name;
  String type;
  Parameter(this.name, this.type);
}

class OperationMethod {
  String name;
  List<String> parameterOrder;
  Message input;
  Message output;
  OperationMethod(this.name, this.parameterOrder);
}

class PortType {
  String name;
  Map<String, OperationMethod> operationMethods;
  PortType(this.name) {
    this.operationMethods = new Map<String, OperationMethod>();
  }
}

class AccessPort {
  String bindingName;
  String address;
  List<PortType> portTypes;
  AccessPort(this.bindingName, this.address) {
    this.portTypes = new List<PortType>();
  }
}

class Binding {
  String name;
  String type;
  Binding(this.name, this.type);
}

class WSDLService {
  String name;
  List<AccessPort> accessPorts;
  WSDLService(this.name) {
    this.accessPorts = new List<AccessPort>();
  }
}

class WSDLDefination {
  String wdslString;
  String xmlns;
  XmlDocument difinations;
  Map<String, Type> complexTypes;
  Map<String, Binding> bindings;
  Map<String, WSDLService> services;
  Map<String, PortType> portTypes;
  Map<String, Message> messages;
  WSDLDefination(this.wdslString) {
    this.difinations = XmlDocument.parse(this.wdslString);
    this.complexTypes = new Map<String, Type>();
    this.bindings = new Map<String, Binding>();
    this.portTypes = new Map<String, PortType>();
    this.messages = new Map<String, Message>();
    this.services = new Map<String, WSDLService>();
    this.execute();
  }
  void execute() {
    this.difinations.children.forEach((root) {
      if (root.nodeType == XmlNodeType.ELEMENT) {
        XmlElement rootElement = root;
        for (var attr in rootElement.attributes) {
          if (attr.name.toString() == 'xmlns:tns') {
            this.xmlns = attr.value;
            break;
          }
        }
        root.children.forEach((node) {
          if (node.nodeType == XmlNodeType.ELEMENT) {
            XmlElement element = node;
            if (element.name.local == 'types') {
              this.executeComplexType(element);
            }
            if (element.name.local == 'message') {
              this.executeMessage(element);
            }
            if (element.name.local == 'portType') {
              this.executePortType(element);
            }
            if (element.name.local == 'binding') {
              this.executeBinding(element);
            }
            if (element.name.local == 'service') {
              this.executeService(element);
            }
            //print('${element.name.local}');
          }
        });
      }
    });
  }

  void executeComplexType(XmlElement typeNode) {
    typeNode.firstElementChild.children.toList().forEach((typeElementNode) {
      if (typeElementNode.nodeType == XmlNodeType.ELEMENT) {
        XmlElement typeElement = typeElementNode;
        if (typeElement.name.local == 'element') {
          final name = typeElement.getAttribute('name');
          final properties = new Map<String, String>();
          if (typeElement.getAttribute('type') != null) {
            return;
          }
          //print('type:$name');
          if (typeElement.firstElementChild.firstElementChild == null) {
            return;
          }
          typeElement.firstElementChild.firstElementChild.children
              .toList()
              .forEach((property) {
            if (property.nodeType == XmlNodeType.ELEMENT) {
              XmlElement pelement = property;
              //print('property:$property');
              if (pelement.name.local == 'element') {
                final pname = pelement.getAttribute('name');
                final ptype = pelement.getAttribute('type');
                if (pname != null && ptype != null) {
                  properties.addAll({pname: ptype});
                }
              }
            }
          });
          final complexType = new Type(name, properties);
          //print('type: $name $properties');
          this.complexTypes.addAll({name: complexType});
        }
      }
    });
  }

  void executeMessage(XmlElement messageNode) {
    final name = messageNode.getAttribute('name');
    final message = Message(name);
    this.messages.addAll({name: message});
    messageNode.children.toList().forEach((partNode) {
      if (partNode.nodeType == XmlNodeType.ELEMENT) {
        XmlElement partElement = partNode;
        if (partElement.name.local == 'part') {
          final partName = partElement.getAttribute('name');
          final partType = partElement.getAttribute('type');
          final messagePart = MessagePart(partName);
          if (partType != null) {
            // 独立参数
            messagePart.isComplex = false;
            messagePart.typeName = partType.split(':').last;
          } else {
            // 对象参数
            final elementType = partElement.getAttribute('element');
            messagePart.isComplex = true;
            messagePart.typeName = elementType.split(':').last;
          }
          message.parts.add(messagePart);
        }
      }
    });
  }

  void executePortType(XmlElement portNode) {
    final name = portNode.getAttribute('name');
    //print('portType name: $name');
    final portType = PortType(name);
    portNode.children.toList().forEach((operationNode) {
      if (operationNode.nodeType == XmlNodeType.ELEMENT) {
        XmlElement operationElement = operationNode;
        if (operationElement.name.local == 'operation') {
          final operName = operationElement.getAttribute('name');

          final parameterOrder =
              operationElement.getAttribute('parameterOrder');
          final operationMethod = OperationMethod(operName,
              parameterOrder != null ? parameterOrder.split(' ') : []);
          portType.operationMethods.addAll({operName: operationMethod});
          operationElement.children.toList().forEach((direction) {
            if (direction.nodeType == XmlNodeType.ELEMENT) {
              XmlElement delement = direction;
              if (delement.name.local != 'input' &&
                  delement.name.local != 'output') {
                return;
              }
              final messageName =
                  delement.getAttribute('message').split(':').last;
              //print('messageName:$messageName');
              final message = this.messages[messageName];
              if (delement.name.local == 'input') {
                operationMethod.input = message;
              }
              if (delement.name.local == 'output') {
                operationMethod.output = message;
              }
            }
          });
        }
      }
    });
    this.portTypes.addAll({name: portType});
  }

  void executeBinding(XmlElement bindingNode) {
    final name = bindingNode.getAttribute('name');
    final type = bindingNode.getAttribute('type').split(':').last;
    this.bindings.addAll({name: Binding(name, type)});
    //print('binding name:$name type:$type');
  }

  void executeService(XmlElement serviceNode) {
    final name = serviceNode.getAttribute('name');
    final service = WSDLService(name);
    this.services.addAll({name: service});
    //print('service:$name');
    serviceNode.children.toList().forEach((portNode) {
      if (portNode.nodeType == XmlNodeType.ELEMENT) {
        XmlElement portElement = portNode;
        if (portElement.name.local == 'port') {
          final bindingName = portNode.getAttribute('binding').split(':').last;
          final address = portNode.firstElementChild.getAttribute('location');
          if (this.bindings.containsKey(bindingName)) {
            final binding = this.bindings[bindingName];
            //print('accbind:${binding.type} $address');
            final accessPort = AccessPort(binding.type, address);
            service.accessPorts.add(accessPort);
            final portType = this.portTypes[binding.type];
            accessPort.portTypes.add(portType);
          }
        }
      }
    });
  }
}
