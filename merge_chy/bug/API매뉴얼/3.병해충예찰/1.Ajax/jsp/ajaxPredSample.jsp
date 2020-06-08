<html>
<head>
<meta http-dquiv="Content-Type" content="text/html" charset="utf-8">
<!-- 공통 CSS, JS 선언 -->
<link href="http://ncpms.rda.go.kr/css/api.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://ncpms.rda.go.kr/js/framework.js"></script>
<script type="text/javascript" src="http://ncpms.rda.go.kr/js/openapi_pred.js"></script>

<script type="text/javascript">
	// Api Key
	npmsApiRequestInfo.apiKey = "";//apiKey - NCPMS에서 신청 후 승인되면 확인 가능
	//서비스 코드
	npmsApiRequestInfo.serviceCode = "SVC51";
	//크로스 도메인 처리를 위한 콜백페이지
	npmsApiRequestInfo.callback = "http://ncpms.rda.go.kr/npmsAPI/api/pred_ajax_local_callback.jsp";
</script>
</head>

<body>
<div id="npms_api_data"></div><!-- HTML 로딩 영역 -->
</body>
</html>