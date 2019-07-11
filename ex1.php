<?php

//$page = file_get_contents("https://developers.google.com/google-ads/api/fields/v2/ad_group_ad");


$doc = new DOMDocument();
@$doc->loadHTMLFile("cached.html");

@$xpath = new DOMXpath($doc);

//iterate over all the element in the outer table
for($i = 1; $i < 1000 ; $i++){
	//is this element selectable ?
	$elements = $xpath->query("//*[@id='field-table']/tbody/tr[{$i}]/td/div/table/tbody/tr[6]/td[2]");

	if (!is_null($elements)) {
		foreach ($elements as $element) {
    	$nodes = $element->childNodes;
    	foreach ($nodes as $node) {
			if($node->nodeValue == "True"){
				extractSubtable($i);
			}
    	}
  	}
	}else{
		//we break once there is nothing left
		break;
	}
}

function caseConverter($input){
	//For now we just remove the _ and convert the char after upper case 
	return str_replace('_', '', lcfirst(ucwords($input, '_')));
}
function makeBool($val){
	if($val=="True"){
		return 1;
	}
	return 0;
}

function extractSubtable($i){
	global $xpath;
	$obj = new class{};
	//*[@id="field-table"]/tbody/tr[2]/th
	$obj->apiName = extractNode($xpath->query("//*[@id='field-table']/tbody/tr[{$i}]/th"));
	$obj->apiPath = caseConverter($obj->apiName);
	$obj->category = extractNode($xpath->query("//*[@id='field-table']/tbody/tr[{$i}]/td/div/table/tbody/tr[2]/td[2]/code/span"));
	$obj->type = extractNode($xpath->query("//*[@id='field-table']/tbody/tr[{$i}]/td/div/table/tbody/tr[3]/td[2]/code/span"));
	if(is_null($obj->type)){
		$obj->type = "ENUM";
	}
	$obj->typeUrl = extractNode($xpath->query("//*[@id='field-table']/tbody/tr[{$i}]/td/div/table/tbody/tr[4]/td[2]/code/span"),true);
	$obj->repeated = extractNode($xpath->query("//*[@id='field-table']/tbody/tr[{$i}]/td/div/table/tbody/tr[8]/td[2]"));
	$obj->repeated = makeBool($obj->repeated);
	//print_r($obj);
	$sql = <<<EOD
INSERT INTO adwordsApi.ad_group_ad SET
protoType = "{$obj->typeUrl}",
apiName = "{$obj->apiName}",
apiPath = "{$obj->apiPath}",
category = "{$obj->category}",
type = "{$obj->type}",
repeated = {$obj->repeated};

EOD;
	echo $sql;
}

function extractNode($elements, $all=false){
	if (!is_null($elements)) {
		foreach ($elements as $element) {
			$nodes = $element->childNodes;
			$res = "";
			foreach ($nodes as $node) {
				if(!$all){
					return $node->nodeValue;
				}else{
					$res .= $node->nodeValue;
				}
			}
			return $res;
		}
  	}
  	return null;
}
