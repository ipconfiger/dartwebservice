import 'package:flutter_test/flutter_test.dart';

import 'package:dartwebservice/dartwebservice.dart';

void main() {
  test('adds one to input values', () {
    final webService = WebService2(wsdlString);
    //webService.display();
    final soap = webService.accessPoints.first
        .makeSoap('queryObjectOut', {'UTF8XmlDoc': 'asdasdasdadasdaasda'});
    print("$soap");
    expect(true, true);
  });
  test('make soap', () {
    final webservice = WebService.fromWsdl(wsdlString);
    webservice.makeSoap('write', {'xmlDoc': 'heiheiheihi'}, {});
    expect(true, true);
  });
}

final wsdlString = '''<?xml version="1.0" encoding="UTF-8"?>
<wsdl:definitions targetNamespace="http://192.168.100.26/pnweb/services/TmriOutNewAccess" xmlns:apachesoap="http://xml.apache.org/xml-soap" xmlns:impl="http://192.168.100.26/pnweb/services/TmriOutNewAccess" xmlns:intf="http://192.168.100.26/pnweb/services/TmriOutNewAccess" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:wsdlsoap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<!--WSDL created by Apache Axis version: 1.4
Built on Apr 22, 2006 (06:55:48 PDT)-->

   <wsdl:message name="writeObjectOutNewResponse">

      <wsdl:part name="writeObjectOutNewReturn" type="xsd:string">

      </wsdl:part>

   </wsdl:message>

   <wsdl:message name="writeObjectOutResponse">

      <wsdl:part name="writeObjectOutReturn" type="xsd:string">

      </wsdl:part>

   </wsdl:message>

   <wsdl:message name="queryObjectOutNewRequest">

      <wsdl:part name="xtlb" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="jkxlh" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="jkid" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="cjsqbh" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="dwjgdm" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="dwmc" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="yhbz" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="yhxm" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="zdbs" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="UTF8XmlDoc" type="xsd:string">

      </wsdl:part>

   </wsdl:message>

   <wsdl:message name="queryObjectOutResponse">

      <wsdl:part name="queryObjectOutReturn" type="xsd:string">

      </wsdl:part>

   </wsdl:message>

   <wsdl:message name="queryObjectOutRequest">

      <wsdl:part name="xtlb" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="jkxlh" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="jkid" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="yhbz" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="dwmc" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="dwjgdm" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="yhxm" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="zdbs" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="UTF8XmlDoc" type="xsd:string">

      </wsdl:part>

   </wsdl:message>

   <wsdl:message name="queryObjectOutNewResponse">

      <wsdl:part name="queryObjectOutNewReturn" type="xsd:string">

      </wsdl:part>

   </wsdl:message>

   <wsdl:message name="writeObjectOutNewRequest">

      <wsdl:part name="xtlb" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="jkxlh" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="jkid" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="cjsqbh" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="dwjgdm" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="dwmc" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="yhbz" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="yhxm" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="zdbs" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="UTF8XmlDoc" type="xsd:string">

      </wsdl:part>

   </wsdl:message>

   <wsdl:message name="writeObjectOutRequest">

      <wsdl:part name="xtlb" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="jkxlh" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="jkid" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="yhbz" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="dwmc" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="dwjgdm" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="yhxm" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="zdbs" type="xsd:string">

      </wsdl:part>

      <wsdl:part name="UTF8XmlDoc" type="xsd:string">

      </wsdl:part>

   </wsdl:message>

   <wsdl:portType name="TmriJaxRpcOutNewAccess">

      <wsdl:operation name="queryObjectOut" parameterOrder="xtlb jkxlh jkid yhbz dwmc dwjgdm yhxm zdbs UTF8XmlDoc">

         <wsdl:input message="impl:queryObjectOutRequest" name="queryObjectOutRequest">

       </wsdl:input>

         <wsdl:output message="impl:queryObjectOutResponse" name="queryObjectOutResponse">

       </wsdl:output>

      </wsdl:operation>

      <wsdl:operation name="queryObjectOutNew" parameterOrder="xtlb jkxlh jkid cjsqbh dwjgdm dwmc yhbz yhxm zdbs UTF8XmlDoc">

         <wsdl:input message="impl:queryObjectOutNewRequest" name="queryObjectOutNewRequest">

       </wsdl:input>

         <wsdl:output message="impl:queryObjectOutNewResponse" name="queryObjectOutNewResponse">

       </wsdl:output>

      </wsdl:operation>

      <wsdl:operation name="writeObjectOut" parameterOrder="xtlb jkxlh jkid yhbz dwmc dwjgdm yhxm zdbs UTF8XmlDoc">

         <wsdl:input message="impl:writeObjectOutRequest" name="writeObjectOutRequest">

       </wsdl:input>

         <wsdl:output message="impl:writeObjectOutResponse" name="writeObjectOutResponse">

       </wsdl:output>

      </wsdl:operation>

      <wsdl:operation name="writeObjectOutNew" parameterOrder="xtlb jkxlh jkid cjsqbh dwjgdm dwmc yhbz yhxm zdbs UTF8XmlDoc">

         <wsdl:input message="impl:writeObjectOutNewRequest" name="writeObjectOutNewRequest">

       </wsdl:input>

         <wsdl:output message="impl:writeObjectOutNewResponse" name="writeObjectOutNewResponse">

       </wsdl:output>

      </wsdl:operation>

   </wsdl:portType>

   <wsdl:binding name="TmriOutNewAccessSoapBinding" type="impl:TmriJaxRpcOutNewAccess">

      <wsdlsoap:binding style="rpc" transport="http://schemas.xmlsoap.org/soap/http"/>

      <wsdl:operation name="queryObjectOut">

         <wsdlsoap:operation soapAction=""/>

         <wsdl:input name="queryObjectOutRequest">

            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://endpoint.axis.framework.tmri.com" use="encoded"/>

         </wsdl:input>

         <wsdl:output name="queryObjectOutResponse">

            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://192.168.100.26/pnweb/services/TmriOutNewAccess" use="encoded"/>

         </wsdl:output>

      </wsdl:operation>

      <wsdl:operation name="queryObjectOutNew">

         <wsdlsoap:operation soapAction=""/>

         <wsdl:input name="queryObjectOutNewRequest">

            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://endpoint.axis.framework.tmri.com" use="encoded"/>

         </wsdl:input>

         <wsdl:output name="queryObjectOutNewResponse">

            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://192.168.100.26/pnweb/services/TmriOutNewAccess" use="encoded"/>

         </wsdl:output>

      </wsdl:operation>

      <wsdl:operation name="writeObjectOut">

         <wsdlsoap:operation soapAction=""/>

         <wsdl:input name="writeObjectOutRequest">

            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://endpoint.axis.framework.tmri.com" use="encoded"/>

         </wsdl:input>

         <wsdl:output name="writeObjectOutResponse">

            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://192.168.100.26/pnweb/services/TmriOutNewAccess" use="encoded"/>

         </wsdl:output>

      </wsdl:operation>

      <wsdl:operation name="writeObjectOutNew">

         <wsdlsoap:operation soapAction=""/>

         <wsdl:input name="writeObjectOutNewRequest">

            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://endpoint.axis.framework.tmri.com" use="encoded"/>

         </wsdl:input>

         <wsdl:output name="writeObjectOutNewResponse">

            <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://192.168.100.26/pnweb/services/TmriOutNewAccess" use="encoded"/>

         </wsdl:output>

      </wsdl:operation>

   </wsdl:binding>

   <wsdl:service name="TmriJaxRpcOutNewAccessService">

      <wsdl:port binding="impl:TmriOutNewAccessSoapBinding" name="TmriOutNewAccess">

         <wsdlsoap:address location="http://192.168.100.26/pnweb/services/TmriOutNewAccess"/>

      </wsdl:port>

   </wsdl:service>

</wsdl:definitions>
''';
