<%
'���ʿ��ϰ� �ǵ��� ������
Response.ContentType = "text/xml"
Response.AddHeader "Pragma", "no-cache"
Response.expires = -1
Response.buffer = True
Response.CharSet = "euc-kr"

	
	url = "http://ncpms.rda.go.kr/npmsAPI/service?"

	For Each pkey In request.Querystring
		url = url & pkey & "=" & Request.QueryString(pkey) & "&"
	Next 

	Set httpObj = Server.CreateObject("WinHttp.WinHttpRequest.5.1")
	httpObj.open "GET", url, False
	
	httpObj.Send()
	httpObj.WaitForResponse
	
	If httpObj.Status = "200" Then
		getSiteSourceGet = httpObj.ResponseBody
		
		response.binaryWrite getSiteSourceGet
		
	Else
		getSiteSourceGet = null
	End If 
	
	Set httpObj = Nothing

%>