<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
<meta name="keywords" content="��������û, ������߻�����, OpenAip" charset="utf-8" />
<title>������ û������ �Բ��ϴ� ��������û(�����濹������ OpenAip Service)</title>
<script type="text/javascript" src="http://ncpms.rda.go.kr/npmsAPI/api/openapiFore.jsp?googleMapKey=[����APIŰ]"></script>
<script type="text/javascript">
	npmsJ(document).ready(function() {
		// Api Key
		setNpmsOpenApiKey( "[�߱޹޴�OpenAPIŰ]" );
		
		// ���� �ڵ�
		setNpmsOpenApiServiceCode("SVC31");
		
		// ũ�ν� ������ ó���� ���� �ݹ�������, �� ���� ���������� �������ּ���.
		setNpmsOpenApiProxyUrl("http://[���񽺵�����]/openapiFore_ajax_callback.jsp");
		
		// ���� ���� : OpenAPI Ư���� 600px ���Ϸδ� ������ �ȵ�
		setNpmsOpenAPIWidth(600);
		
		// ��ġ ���� : setRegion( [������ Ȥ�� �ּ�], [�� ����] )
		// ������ �߽��̵Ǵ� ���� Ȥ�� �ּҸ� �־��ּ���.
		// �� ������ �����Ͻþ� �������� ������ŭ�� �� ������ �����ϼ���.(�� : �������� 9, �ñ� ������ 11)
		setRegion("���󳲵� ������ ��㸮", 14);
		
		// ���� �۸�
		// �۸��ڵ� - ����:FT060614,����:FC050501,����:VC011205,��:FC010101,��:FT010602,���:FT010601,��:VC041202,����:FT040603
		// ���� �ϰ� ���� �۸��ڵ带 cropList �迭�� �߰��Ͽ� �ּ���. �߰��� ������ ����� �������ϴ�.
		var cropList = new Array('FC010101', 'FT010601','VC011205');
		setCropList(cropList);
		
		// ���� ������ ���� ����
		setMoveMatAt( false );
		
		// ���񽺿�û
		actionMapInfo("defaultTag");
	});
</script>
</head>
<body>
	<div id="defaultTag"></div>
</body>
</html>