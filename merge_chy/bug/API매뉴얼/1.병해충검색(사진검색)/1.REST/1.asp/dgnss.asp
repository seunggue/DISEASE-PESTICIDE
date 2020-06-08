<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<script type='text/javascript'>

//����ȭ������ �̵�
function fncNextPage(cCode, cName){
	with(document.apiForm){
		cropSectionCode.value = cCode;
		cropSectionName.value = cName;
		method="get";
		if(cCode=="6"){	//������ ���
			action = "dgnss2.asp";
		}else{			//���ʰ� �ƴ� ���
			action = "dgnss1.asp";
		}
		target = "_self";
		submit();
	}
}

</script>
</head>

<body>
<form name="apiForm">
<input type="hidden" name="cropSectionCode"/>
<input type="hidden" name="cropSectionName"/>

<%

'�������۹� ����������ý��ۿ��� �߱޹��� ����Ű
apiKey = ""

'�����˻� 1�� �����ڵ�(���� ������ Open API �̿�ȳ� ����)
serviceCode = "SVC11"

'XML ���� URL ����
parameter = "apiKey="&apiKey
parameter = parameter & "&serviceCode=" & serviceCode

targetURL = "http://ncpms.rda.go.kr/npmsAPI/service?" & parameter


'�������۹� ��������� �ý��۰� Open API ��� ����
Set xmlHttp = Server.CreateObject("Microsoft.XMLHTTP")    
xmlHttp.Open "GET", targetURL, False   
xmlHttp.Send    


Set oStream = CreateObject("ADODB.Stream")   
oStream.Open   
oStream.Position = 0   
oStream.Type = 1   
oStream.Write xmlHttp.ResponseBody   
oStream.Position = 0   
oStream.Type = 2   
oStream.Charset = "utf-8"   
sText = oStream.ReadText   
oStream.Close   

Set xmlDOM = server.CreateObject("MSXML.DOMDOCUMENT")   
xmlDOM.async = False    
xmlDOM.LoadXML sText   
'�������۹� ��������� �ý��۰� Open API ��� ��
     
'�����ڵ� : ��� �� ���� �߻��� �ڵ尡 ���ɴϴ�.
Set errorCode = xmlDOM.SelectNodes("//errorCode")
If Not errorCode(0) Is Nothing Then errorCodeText= errorCode(0).Text Else errorCodeText = "" End If

'�����޽��� : �����ڵ忡 ���� �޽��� �Դϴ�.
Set errorMsg = xmlDOM.SelectNodes("//errorMsg")
If Not errorMsg(0) Is Nothing Then errorMsgText= errorMsg(0).Text Else errorMsgText = "" End If

'xml �����ð� 
Set buildTime = xmlDOM.SelectNodes("//buildTime")
If Not buildTime(0) Is Nothing Then buildTimeText= buildTime(0).Text Else buildTimeText = "" End If

'��ü ��ȸ �Ǽ� : ����¡ ó�� �� ���
Set totalCount = xmlDOM.SelectNodes("//totalCount")
If Not totalCount(0) Is Nothing Then totalCountText= totalCount(0).Text Else totalCountText = "0" End If

'��������Ʈ : ����¡ ó�� �� ���
Set startPoint = xmlDOM.SelectNodes("//startPoint")
If Not startPoint(0) Is Nothing Then startPointText= startPoint(0).Text Else startPointText = "1" End If

'ȭ����°��� : ����¡ ó�� �� ���
Set displayCount = xmlDOM.SelectNodes("//displayCount")
If Not displayCount(0) Is Nothing Then displayCountText= displayCount(0).Text Else displayCountText = "20" End If

%>


    <%If errorCodeText <> ""  Then%>
      ��������û �������۹� �����ý��� OpenAPI ȣ�� �� ��ְ� �߻��Ͽ����ϴ�.<br/>����Ŀ� �ٽ� �̿��Ͻʽÿ�.
	  <br/>
	  <%=errorMsg%>
	<%Else
	
		'���� ��� �Ľ�
		Set listItem = xmlDOM.SelectNodes("//list")
		cnt = listItem(0).childNodes.length
		Set items = listItem(0).childNodes
	%>
				<table  border="0" cellspacing="0" cellpadding="0">
				<%If cnt = 0 Then%>
					<tr>
						<td width="100%" valign="top" style="padding-top:12px;">��ȸ�� ������ �����ϴ�.</td>
                    </tr> 
                <%Else
					'���� ����� �Ľ��Ͽ� ���
					For i=0 To cnt-1
					   Set itemNode = items.item(i)

						If NOT itemNode Is Nothing Then
							'������
							If NOT itemNode.SelectSingleNode("cropSectionName") is Nothing Then
								cropSectionName = itemNode.SelectSingleNode("cropSectionName").text
							End If
							'����URL
							If NOT itemNode.SelectSingleNode("thumbImg") is Nothing Then
								thumbImg = itemNode.SelectSingleNode("thumbImg").text
							End If

							'�����˻�2�� ���� Ű��.
							If NOT itemNode.SelectSingleNode("cropSectionCode") is Nothing Then
								cropSectionCode = itemNode.SelectSingleNode("cropSectionCode").text
							End If
						End If

				%>
				<!-- ���ٿ� ������ 4���� ����ϵ��� ���� -->
				<%If (i Mod 4) = 0 Then%>
				    <tr>
				<%End If%>
						<!-- ��� ��� -->
                      <td width="25%" valign="top" style="padding-top:12px;text-align:center;"> 
					  
                        <a href="javascript:fncNextPage('<%=cropSectionCode%>','<%=cropSectionName%>');">
							<img src="<%=thumbImg%>" width="100px" height="85px" border="0" alt="" style="border:1px #CCC solid;  padding:10px "   />
						</a>
						<br/>
						<span style="padding-top:5px;letter-spacing: -1px; word-spacing: 0px;">
							<a href="javascript:fncNextPage('<%=cropSectionCode%>','<%=cropSectionName%>');" style="text-align:center;"><%=cropSectionName%></a> 
                        </span>
                        
                        
                        </td>
				<%If (i Mod 4) = 3 Then%>
				    </tr>
				<%End If%>
				<%
					   Set itemNode = Nothing
					Next
				End If
				%>

                    
                  </table>
	<%End If%>
</form>
</body>
</html>