library dartwebservice;

import 'package:xml/xml.dart';

import 'wsdl.dart';

class InvalidDefinationException implements Exception {
  String error;
  InvalidDefinationException(this.error);
  String errMsg() => this.error;
}

class InvalidInvokeException implements Exception {
  String error;
  InvalidInvokeException(this.error);
  String errMsg() => this.error;
}

class InvalidParameterException implements Exception {
  String error;
  InvalidParameterException(this.error);
  String errMsg() => this.error;
}

class TransParameter {
  String parameterName;
  String typeDefinition;
  TransParameter(this.parameterName, this.typeDefinition);
}

class TransType {
  String typeName;
  bool isComplex;
  List<TransParameter> parameters;
  Map<String, bool> paramsMap;
  TransType(this.typeName) {
    this.parameters = <TransParameter>[];
    this.paramsMap = new Map<String, bool>();
  }
}

class ComplexType {
  String typeName;
  List<TransParameter> propertys;
  ComplexType(this.typeName) {
    this.propertys = <TransParameter>[];
  }
}

class Interface {
  String interfaceName;
  TransType inputs;
  TransType outputs;
}

class Param {
  String name;
  String type;
  Param(this.name, this.type);
}

class Method {
  String name;
  String inputName;
  List<Param> inputParams;
  String outputName;
  List<Param> outputParams;
  Method(this.name) {
    this.inputParams = <Param>[];
    this.outputParams = <Param>[];
  }
}

class AccessPoint {
  String xmlns;
  String name;
  String address;
  List<Method> methods;
  AccessPoint(this.xmlns, this.name, this.address) {
    this.methods = <Method>[];
  }

  String makeSoap(String method, Map<String, String> params) {
    Method m;
    for (var md in this.methods) {
      if (md.name.compareTo(method) > 0) {
        m = md;
        break;
      }
    }
    if (m == null) {
      throw InvalidInvokeException('Method $method not exists');
    }
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('soap12:Envelope', nest: () {
      builder.attribute(
          'xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
      builder.attribute('xmlns:xsd', 'http://www.w3.org/2001/XMLSchema');
      builder.attribute(
          'xmlns:soap12', 'http://www.w3.org/2003/05/soap-envelope');
      builder.element('soap12:Body', nest: () {
        builder.element(method, attributes: {'xmlns': xmlns}, nest: () {
          for (var pname in m.inputParams) {
            builder.element(pname.name, nest: () {
              builder.text(
                  params.containsKey(pname.name) ? params[pname.name] : "");
            });
          }
        });
      });
    });
    final xml = builder.buildDocument();
    return xml.toXmlString();
  }
}

class WebService2 {
  String wsdlString;
  WSDLDefination wsdlDefinition;
  List<AccessPoint> accessPoints;
  WebService2(this.wsdlString) {
    this.wsdlDefinition = WSDLDefination(this.wsdlString);
    this.accessPoints = <AccessPoint>[];
    this.wsdlDefinition.services.values.toList().forEach((service) {
      service.accessPorts.forEach((accessPort) {
        final accessPoints = AccessPoint(
            wsdlDefinition.xmlns, accessPort.bindingName, accessPort.address);
        //print('accessPoints:${accessPort.bindingName} ${accessPort.address}');
        accessPort.portTypes.first.operationMethods
            .forEach((methodName, operationMethods) {
          //print(' method: $methodName ${operationMethods.input}');
          final method = Method(operationMethods.name);
          method.inputName = operationMethods.input.name;
          operationMethods.input.parts.forEach((part) {
            if (part.isComplex) {
              if (part.typeName == 'ArrayOfString') {
                method.outputParams
                    .add(Param('ArrayOfString', 'ArrayOfString'));
              } else {
                final ctype = this.wsdlDefinition.complexTypes[part.typeName];
                if (ctype != null && ctype.prototypes != NullThrownError()) {
                  //print('want type:${part.typeName} got ${ctype.prototypes}');
                  ctype.prototypes.forEach((key, value) {
                    method.inputParams.add(Param(key, value));
                  });
                }
              }
            } else {
              method.inputParams.add(Param(part.name, part.typeName));
            }
          });
          method.outputName = operationMethods.output.name;
          operationMethods.output.parts.forEach((part) {
            if (part.isComplex) {
              if (part.typeName == 'ArrayOfString') {
                method.outputParams
                    .add(Param('ArrayOfString', 'ArrayOfString'));
              } else {
                final ctype = this.wsdlDefinition.complexTypes[part.typeName];
                if (ctype != null && ctype.prototypes != null) {
                  ctype.prototypes.forEach((key, value) {
                    method.outputParams.add(Param(key, value));
                  });
                }
              }
            } else {
              method.outputParams.add(Param(part.name, part.typeName));
            }
          });
          accessPoints.methods.add(method);
        });
        this.accessPoints.add(accessPoints);
      });
    });
  }
  void display() {
    this.accessPoints.forEach((accessPoint) {
      print('accessPoint:${accessPoint.name} url:${accessPoint.address}');
      accessPoint.methods.forEach((method) {
        print('    method:${method.name}');
        print('        input:${method.inputName}');
        method.inputParams.forEach((param) {
          print('            param:${param.name} ${param.type}');
        });
        print('        output:${method.outputName}');
        method.outputParams.forEach((param) {
          print('            param:${param.name} ${param.type}');
        });
      });
    });
  }
}

class WebService {
  String wsdl;
  XmlDocument difinations;
  Map<String, TransType> types;
  Map<String, ComplexType> complexTypes;
  Map<String, Interface> interfaceMap;
  List<Interface> interfacies;
  XmlDocument soapRoot;

  WebService.fromWsdl(this.wsdl) {
    this.difinations = XmlDocument.parse(this.wsdl);
    this.types = new Map<String, TransType>();
    this.interfacies = <Interface>[];
    this.interfaceMap = new Map<String, Interface>();
    this.complexTypes = new Map<String, ComplexType>();
    this.soapRoot = new XmlDocument();
  }

  String makeSoap(String name, Map<String, String> parameters,
      Map<String, String> payload) {
    this.execute();
    if (!this.interfaceMap.containsKey(name)) {
      throw InvalidInvokeException('Invalid method');
    }
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('soap12:Envelope', nest: () {
      builder.attribute(
          'xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
      builder.attribute('xmlns:xsd', 'http://www.w3.org/2001/XMLSchema');
      builder.attribute(
          'xmlns:soap12', 'http://www.w3.org/2003/05/soap-envelope');
      builder.element('soap12:Body', nest: () {
        builder.element(name, nest: () {
          final interface = this.interfaceMap[name];
          print('interface:$name');
          for (var pname in parameters.keys) {
            if (!interface.inputs.paramsMap.containsKey(pname)) {
              throw InvalidParameterException('$pname not in parameters list');
            }
            builder.element(pname, nest: () {
              builder.text(parameters[pname]);
            });
          }
        });
      });
    });
    final bookshelfXml = builder.buildDocument();
    print('xml:$bookshelfXml');
    return bookshelfXml.toXmlString();
  }

  void execute() {
    this.difinations.descendants.forEach((node) {
      // 解析类型
      if (node.toString().startsWith('<wsdl:types')) {
        final typeList = node.firstElementChild.children.toList();
        //print('detect types!!:${typeList.toList()}');
        for (var el in typeList) {
          if (el.nodeType == XmlNodeType.TEXT) {
            continue;
          }
          final typeName = el.getAttribute('name');
          //print('type name:$typeName');
          final tp = ComplexType(typeName);
          if (el.firstElementChild == null) {
            continue;
          }
          if (el.firstElementChild.firstElementChild == null) {
            continue;
          }
          final propertyList =
              el.firstElementChild.firstElementChild.children.toList();
          for (var property in propertyList) {
            if (property.nodeType == XmlNodeType.TEXT) {
              continue;
            }
            final propertyName = property.getAttribute('name');
            final propertyType = property.getAttribute('type');
            final p = new TransParameter(propertyName, propertyType);
            tp.propertys.add(p);
          }
          this.complexTypes[typeName] = tp;
        }
      }
    });
    print('complex types:${this.complexTypes}');
    this.difinations.descendants.forEach((node) {
      // 解析接口
      if (node.toString().startsWith('<wsdl:message')) {
        final name = node.getAttribute('name');
        //print('type: $name');
        final tp = TransType(name);
        node.children.forEach((subnode) {
          if (subnode.toString().startsWith('<wsdl:part')) {
            if (subnode.getAttribute('element') != null) {
              final elementName = subnode.getAttribute('element').split(':')[1];
              //print('part name:$elementName');
              if (this.complexTypes.containsKey(elementName)) {
                tp.isComplex = true;
                this.complexTypes[elementName].propertys.forEach((p) {
                  tp.parameters.add(p);
                  tp.paramsMap[p.parameterName] = true;
                });
              }
            } else {
              final p = new TransParameter(
                  subnode.getAttribute('name'), subnode.getAttribute('type'));
              tp.parameters.add(p);
              tp.paramsMap[p.parameterName] = true;
            }
          }
        });
        this.types.addAll({name: tp});
      }
    });
    // 解析端口
    this.difinations.descendants.forEach((node) {
      if (node.toString().startsWith('<wsdl:portType')) {
        node.children.forEach((child) {
          if (child.toString().startsWith('<wsdl:operation')) {
            final name = child.getAttribute('name');
            Interface ins = new Interface();
            ins.interfaceName = name;
            child.children.forEach((sub) {
              if (sub.toString().startsWith('<wsdl:input')) {
                // 获取到输入定义
                final inputName = sub.getAttribute('message').split(':')[1];
                if (!this.types.containsKey(inputName)) {
                  throw new InvalidDefinationException(
                      'Message $inputName not found');
                }
                ins.inputs = this.types[inputName];
                //print('inputtype: $inputName');
              }
              if (sub.toString().startsWith('<wsdl:output')) {
                // 获取到输出定义
                final outName = sub.getAttribute('message').split(':')[1];
                if (!this.types.containsKey(outName)) {
                  throw new InvalidDefinationException(
                      'Message $outName not found');
                }
                ins.outputs = this.types[outName];
                //print('outputtype: $outName');
              }
            });
            interfacies.add(ins);
            this.interfaceMap[name] = ins;
          }
        });
      }
    });

    this.interfacies.forEach((interface) {
      print('interface:${interface.interfaceName}');
      print('input type:${interface.inputs.typeName}');
      interface.inputs.parameters.forEach((param) {
        print(
            '\t param name:${param.parameterName} or type:${param.typeDefinition}');
      });
      print('output type:${interface.outputs.typeName}');
      interface.outputs.parameters.forEach((param) {
        print(
            '\t param name:${param.parameterName} or type:${param.typeDefinition}');
      });
    });
  }
}
