<% @CODEPAGE="65001" language="VBScript" %>
<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<script type='text/javascript'>

//페이지 이동
function fncGoPage(start){
	with(document.apiForm){
		startPoint.value = start;
		method="get";
		action = "dgnss1.asp";
		target = "_self";
		submit();
	}
}

//다음화면으로 이동
function fncNextPage(cCode, cName, start){
	with(document.apiForm){
		cropCode.value = cCode;
		cropName.value = cName;
		bfStartPoint.value = start;
		method="get";
		action = "dgnss2.asp";
		target = "_self";
		submit();
	}
}

</script>
</head>

<body>
<form name="apiForm">
<input type="hidden" name="startPoint" value=""/>
<input type="hidden" name="bfStartPoint" value=""/>
<input type="hidden" name="cropSectionCode" value="<%=Request("cropSectionCode")%>"/>
<input type="hidden" name="cropSectionName" value="<%=Request("cropSectionName")%>"/>
<input type="hidden" name="cropCode" value=""/>
<input type="hidden" name="cropName" value=""/>

<%

'국가농작물 병해충관리시스템에서 발급받은 인증키
apiKey = ""

'사진검색 1의 서비스코드(상세한 내용은 Open API 이용안내 참조)
serviceCode = "SVC12"

'XML 받을 URL 생성
parameter = "apiKey="&apiKey
parameter = parameter & "&serviceCode=" & serviceCode
parameter = parameter & "&cropSectionCode=" & Request("cropSectionCode")

'페이지 이동 처리
If NOT Request("startPoint") Is Nothing Then
	parameter = parameter & "&startPoint=" & Request("startPoint")
ElseIf NOT Request("bfStartPoint") Is Nothing Then
	parameter = parameter & "&startPoint=" & Request("bfStartPoint")
End If


targetURL = "http://ncpms.rda.go.kr/npmsAPI/service?" & parameter


'국가농작물 병해충관리 시스템과 Open API 통신 시작
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
'국가농작물 병해충관리 시스템과 Open API 통신 끝
     
'에러코드 : 통신 후 에러 발생시 코드가 나옵니다.
Set errorCode = xmlDOM.SelectNodes("//errorCode")
If Not errorCode(0) Is Nothing Then errorCodeText= errorCode(0).Text Else errorCodeText = "" End If

'에러메시지 : 에러코드에 대한 메시지 입니다.
Set errorMsg = xmlDOM.SelectNodes("//errorMsg")
If Not errorMsg(0) Is Nothing Then errorMsgText= errorMsg(0).Text Else errorMsgText = "" End If

'xml 생성시간 
Set buildTime = xmlDOM.SelectNodes("//buildTime")
If Not buildTime(0) Is Nothing Then buildTimeText= buildTime(0).Text Else buildTimeText = "" End If

'전체 조회 건수 : 페이징 처리 시 사용
Set totalCount = xmlDOM.SelectNodes("//totalCount")
If Not totalCount(0) Is Nothing Then totalCountText= totalCount(0).Text Else totalCountText = "0" End If

'시작포인트 : 페이징 처리 시 사용
Set startPoint = xmlDOM.SelectNodes("//startPoint")
If Not startPoint(0) Is Nothing Then startPointText= startPoint(0).Text Else startPointText = "1" End If

'화면출력갯수 : 페이징 처리 시 사용
Set displayCount = xmlDOM.SelectNodes("//displayCount")
If Not displayCount(0) Is Nothing Then displayCountText= displayCount(0).Text Else displayCountText = "20" End If

%>


    <%If errorCodeText <> ""  Then%>
      농촌진흥청 국가농작물 관리시스템 OpenAPI 호출 시 장애가 발생하였습니다.<br/>잠시후에 다시 이용하십시오.
	  <br/>
	  <%=errorMsg%>
	<%Else
	
		'사진 목록 파싱
		Set listItem = xmlDOM.SelectNodes("//list")
		cnt = listItem(0).childNodes.length
		Set items = listItem(0).childNodes
	%>
				<table  border="0" cellspacing="0" cellpadding="0">
				<%If cnt = 0 Then%>
					<tr>
						<td width="100%" valign="top" style="padding-top:12px;">조회한 정보가 없습니다.</td>
                    </tr> 
                <%Else
					'사진 목록을 파싱하여 출력
					For i=0 To cnt-1
					   Set itemNode = items.item(i)

						If NOT itemNode Is Nothing Then
							If NOT itemNode.SelectSingleNode("cropName") is Nothing Then '작물명
								cropName = itemNode.SelectSingleNode("cropName").text
							End If
							If NOT itemNode.SelectSingleNode("thumbImg") is Nothing Then '이미지 URL
								thumbImg = itemNode.SelectSingleNode("thumbImg").text
							End If
							If NOT itemNode.SelectSingleNode("cropCode") is Nothing Then '작물코드(사진검색3를 위한 키값)
								cropCode = itemNode.SelectSingleNode("cropCode").text
							End If
						End If

				%>
				<!-- 한줄에 사진을 4개씩 출력하도록 구성 -->
				<%If (i Mod 4) = 0 Then%>
				    <tr>
				<%End If%>
						<!-- 목록 출력 -->
                      <td width="25%" valign="top" style="padding-top:12px;text-align:center;"> 
					  
                        <a href="javascript:fncNextPage('<%=cropCode%>', '<%=cropName%>', '<%=startPointText%>');">
							<img src="<%=thumbImg%>" width="100px" height="85px" border="0" alt="" style="border:1px #CCC solid;  padding:10px "   />
						</a>
						<br/>
						<span style="padding-top:5px;letter-spacing: -1px; word-spacing: 0px;">
							<a href="javascript:fncNextPage('<%=cropCode%>', '<%=cropName%>', '<%=startPointText%>');" style="text-align:center;"><%=cropName%></a> 
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


	<br/>

<%
   function ceil(x)

        dim temp
        temp = Round(x)
        if temp < x then
            temp = temp + 1
        end if
        ceil = temp
    end function


	pageGroupSize = 10
	pageSize = Int(displayCountText)
	

	start = Int(startPointText)

	
	currentPage = ceil(start / pageSize)

	startRow = (currentPage - 1) * pageSize + 1
	endRow = currentPage * pageSize
	count = Int(totalCountText)
	number=0                                                    
		
	number=count-(currentPage-1)*pageSize    
	
	pageGroupCount = count/(pageSize*pageGroupSize)

	numPageGroup = Int(ceil(currentPage/pageGroupSize))

	If count > 0 Then
		pageCount = Int(count / pageSize)


		If (count Mod pageSize) = 0 Then
			pageCount = pageCount + 0
		Else
			pageCount = pageCount + 1
		End If

		startPage = pageGroupSize*(numPageGroup-1)+1
		endPage = startPage + pageGroupSize-1
		pageNo = 0
		startPoint = 0
		
		If endPage > pageCount Then
			endPage = pageCount
		End If

		If numPageGroup > 1 Then
			pageNo = (numPageGroup-2)*pageGroupSize+1
			startPoint = ((pageNo-1)*pageSize)+1
			Response.Write("<a href='javascript:fncGoPage("&startPoint&");'>[이전]</a>")
		End If

		i=startPage
		While i<=endPage

			pageNo = i
			startPoint = ((pageNo-1)*pageSize)+1
			Response.Write("<a href='javascript:fncGoPage("&startPoint&");'>")

			If currentPage = i Then
				Response.Write("<strong>["&i&"]</strong>")
			Else
				Response.Write("["&i&"]")
			End If

			Response.Write("</a>")

			i = i+1
		Wend

		If numPageGroup < pageGroupCount Then
			pageNo = (numPageGroup*pageGroupSize+1)
			startPoint = ((pageNo-1)*pageSize)+1
			Response.Write("<a href='javascript:fncGoPage("&startPoint&");'>[다음]</a>")
		End If
	End If
%>

	<%End If%>

</form>

<br/>
<input type="button" onclick="javascript:location.href='dgnss.asp'" value="이전화면으로"/>
</body>
</html>