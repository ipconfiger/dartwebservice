import 'package:flutter_test/flutter_test.dart';

import 'package:dartwebservice/dartwebservice.dart';

void main() {
  test('adds one to input values', () {
    final webservice = WebService.fromWsdl(wsdlString);
    webservice.execute();
    expect(true, true);
  });
  test('make soap', () {
    final webservice = WebService.fromWsdl(wsdlString);
    webservice.makeSoap('write', {'xmlDoc': 'heiheiheihi'}, {});
    expect(true, true);
  });
}

final wsdlString = '''<?xml version="1.0" encoding="utf-8"?>
<wsdl:definitions xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:tm="http://microsoft.com/wsdl/mime/textMatching/" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:tns="http://tempuri.org/" xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" targetNamespace="http://tempuri.org/" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/">
  <wsdl:types>
    <s:schema elementFormDefault="qualified" targetNamespace="http://tempuri.org/">
      <s:element name="query">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="xmlDoc" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="queryResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="queryResult" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="write">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="xmlDoc" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="writeResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="writeResult" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="string" nillable="true" type="s:string" />
    </s:schema>
  </wsdl:types>
  <wsdl:message name="querySoapIn">
    <wsdl:part name="parameters" element="tns:query" />
  </wsdl:message>
  <wsdl:message name="querySoapOut">
    <wsdl:part name="parameters" element="tns:queryResponse" />
  </wsdl:message>
  <wsdl:message name="writeSoapIn">
    <wsdl:part name="parameters" element="tns:write" />
  </wsdl:message>
  <wsdl:message name="writeSoapOut">
    <wsdl:part name="parameters" element="tns:writeResponse" />
  </wsdl:message>
  <wsdl:message name="queryHttpGetIn">
    <wsdl:part name="xmlDoc" type="s:string" />
  </wsdl:message>
  <wsdl:message name="queryHttpGetOut">
    <wsdl:part name="Body" element="tns:string" />
  </wsdl:message>
  <wsdl:message name="writeHttpGetIn">
    <wsdl:part name="xmlDoc" type="s:string" />
  </wsdl:message>
  <wsdl:message name="writeHttpGetOut">
    <wsdl:part name="Body" element="tns:string" />
  </wsdl:message>
  <wsdl:message name="queryHttpPostIn">
    <wsdl:part name="xmlDoc" type="s:string" />
  </wsdl:message>
  <wsdl:message name="queryHttpPostOut">
    <wsdl:part name="Body" element="tns:string" />
  </wsdl:message>
  <wsdl:message name="writeHttpPostIn">
    <wsdl:part name="xmlDoc" type="s:string" />
  </wsdl:message>
  <wsdl:message name="writeHttpPostOut">
    <wsdl:part name="Body" element="tns:string" />
  </wsdl:message>
  <wsdl:portType name="VeptsOutAccessSoap">
    <wsdl:operation name="query">
      <wsdl:input message="tns:querySoapIn" />
      <wsdl:output message="tns:querySoapOut" />
    </wsdl:operation>
    <wsdl:operation name="write">
      <wsdl:input message="tns:writeSoapIn" />
      <wsdl:output message="tns:writeSoapOut" />
    </wsdl:operation>
  </wsdl:portType>
  <wsdl:portType name="VeptsOutAccessHttpGet">
    <wsdl:operation name="query">
      <wsdl:input message="tns:queryHttpGetIn" />
      <wsdl:output message="tns:queryHttpGetOut" />
    </wsdl:operation>
    <wsdl:operation name="write">
      <wsdl:input message="tns:writeHttpGetIn" />
      <wsdl:output message="tns:writeHttpGetOut" />
    </wsdl:operation>
  </wsdl:portType>
  <wsdl:portType name="VeptsOutAccessHttpPost">
    <wsdl:operation name="query">
      <wsdl:input message="tns:queryHttpPostIn" />
      <wsdl:output message="tns:queryHttpPostOut" />
    </wsdl:operation>
    <wsdl:operation name="write">
      <wsdl:input message="tns:writeHttpPostIn" />
      <wsdl:output message="tns:writeHttpPostOut" />
    </wsdl:operation>
  </wsdl:portType>
  <wsdl:binding name="VeptsOutAccessSoap" type="tns:VeptsOutAccessSoap">
    <soap:binding transport="http://schemas.xmlsoap.org/soap/http" />
    <wsdl:operation name="query">
      <soap:operation soapAction="http://tempuri.org/query" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="write">
      <soap:operation soapAction="http://tempuri.org/write" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
  </wsdl:binding>
  <wsdl:binding name="VeptsOutAccessSoap12" type="tns:VeptsOutAccessSoap">
    <soap12:binding transport="http://schemas.xmlsoap.org/soap/http" />
    <wsdl:operation name="query">
      <soap12:operation soapAction="http://tempuri.org/query" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="write">
      <soap12:operation soapAction="http://tempuri.org/write" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
  </wsdl:binding>
  <wsdl:binding name="VeptsOutAccessHttpGet" type="tns:VeptsOutAccessHttpGet">
    <http:binding verb="GET" />
    <wsdl:operation name="query">
      <http:operation location="/query" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="write">
      <http:operation location="/write" />
      <wsdl:input>
        <http:urlEncoded />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
  </wsdl:binding>
  <wsdl:binding name="VeptsOutAccessHttpPost" type="tns:VeptsOutAccessHttpPost">
    <http:binding verb="POST" />
    <wsdl:operation name="query">
      <http:operation location="/query" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="write">
      <http:operation location="/write" />
      <wsdl:input>
        <mime:content type="application/x-www-form-urlencoded" />
      </wsdl:input>
      <wsdl:output>
        <mime:mimeXml part="Body" />
      </wsdl:output>
    </wsdl:operation>
  </wsdl:binding>
  <wsdl:service name="VeptsOutAccess">
    <wsdl:port name="VeptsOutAccessSoap" binding="tns:VeptsOutAccessSoap">
      <soap:address location="http://192.168.174.2/hbjcxweb/services/VeptsOutAccess.asmx" />
    </wsdl:port>
    <wsdl:port name="VeptsOutAccessSoap12" binding="tns:VeptsOutAccessSoap12">
      <soap12:address location="http://192.168.174.2/hbjcxweb/services/VeptsOutAccess.asmx" />
    </wsdl:port>
    <wsdl:port name="VeptsOutAccessHttpGet" binding="tns:VeptsOutAccessHttpGet">
      <http:address location="http://192.168.174.2/hbjcxweb/services/VeptsOutAccess.asmx" />
    </wsdl:port>
    <wsdl:port name="VeptsOutAccessHttpPost" binding="tns:VeptsOutAccessHttpPost">
      <http:address location="http://192.168.174.2/hbjcxweb/services/VeptsOutAccess.asmx" />
    </wsdl:port>
  </wsdl:service>
</wsdl:definitions>''';
