library dartwebservice;

import 'package:xml/xml.dart';

class InvalidDefinationException implements Exception { 
  String error;
  InvalidDefinationException(this.error);
  String errMsg() => this.error; 
} 

class TransParameter{
  String parameterName;
  String typeDefinition;
  TransParameter(this.parameterName, this.typeDefinition);
}

class TransType {
  String typeName;
  List<TransParameter> parameters;
  TransType(this.typeName){
    this.parameters = new List<TransParameter>();
  }
}

class Interface {
  String interfaceName;
  TransType inputs;
  TransType outputs;
}

class WebService {
  String wsdl;
  XmlDocument difinations;
  Map<String, TransType> types;
  WebService.fromWsdl(this.wsdl) {
    this.difinations = XmlDocument.parse(this.wsdl);
    this.types = new Map<String, TransType>();
  }

  void execute() {
    this.difinations.descendants.forEach((node) { 
      // 解析类型
      if (node.toString().startsWith('<wsdl:message')){
        final name = node.getAttribute('name');
        print('type: $name');
        final tp = TransType(name);
        node.children.forEach((subnode){
          if (subnode.toString().startsWith('<wsdl:part')){
            print('\t property:${subnode.getAttribute('name')}[${subnode.getAttribute('type')}]');
            final p = new TransParameter(subnode.getAttribute('name'), subnode.getAttribute('type'));
            tp.parameters.add(p);
          }
        });
        this.types.addAll({
          name: tp
        });
      }
    });
    // 解析端口
    this.difinations.descendants.forEach((node) { 
      if (node.toString().startsWith('<wsdl:portType')){
         node.children.forEach((child){
           if (child.toString().startsWith('<wsdl:operation')){
             final name = child.getAttribute('name');
             final paramsOrder = child.getAttribute('parameterOrder');
             print('interface $name, params:$paramsOrder');
             Interface ins = new Interface();
             ins.interfaceName = name;
             child.children.forEach((sub){
               if (sub.toString().startsWith('<wsdl:input')) {
                 // 获取到输入定义
                 final inputName = sub.getAttribute('message').split(':')[1];
                 if (!this.types.containsKey(inputName)){
                   throw new InvalidDefinationException('Message $inputName not found');
                 }
                 ins.inputs = this.types[inputName];
                 print('inputtype: $inputName');
               }
               if (sub.toString().startsWith('<wsdl:output')) {
                 // 获取到输出定义
                 final outName = sub.getAttribute('message').split(':')[1];
                 if (!this.types.containsKey(outName)){
                   throw new InvalidDefinationException('Message $outName not found');
                 }
                 ins.outputs = this.types[outName];
                 print('outputtype: $outName');
               }
             });
           }
         });
      }
    });

  }
  

}