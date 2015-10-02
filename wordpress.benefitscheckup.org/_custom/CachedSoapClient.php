<?php
define ('doScreening',false);
define ('doTriage',false);

class CachedSoapClient extends SoapClient {

    private $__useCache;

    private $__version = "";

    private $__cache;

    private $__subsetId;

    public function CachedSoapClient ($wsdl, array $options = null, $subsetId = 0, $useCache = doTriage) {
        $this->__useCache = $useCache;
        $this->__subsetId = $subsetId;
        parent::SoapClient($wsdl,$options);
        if ($this->__useCache) {
            $this->__version = parent::__call("getQuestionnaireVersion", array(0=>$subsetId));
            $this->__cache = apc_fetch('CachedSoapClientRequests_'.$this->__subsetId);
            if (!$this->__cache) $this->__cache = array();
        }
    }

    function __destruct() {
        if ($this->__useCache) apc_store("CachedSoapClientRequests_".$this->__subsetId,$this->__cache,0);
    }

    public function __call($function_name, $arguments) {
        if ($this->__useCache) {
            $cache_file_name = $_SERVER['DOCUMENT_ROOT'] . "/cache/" . $function_name . "?";
            foreach ($arguments as $key => $value) {
                $cache_file_name = $cache_file_name . "arg[" . $key . "]=" . $value . "&";
            }
            $cache_file_name = rtrim($cache_file_name, "&");
            if ($this->__cache[$cache_file_name]) {
                $v_result = $this->__cache[$cache_file_name];
                if ($v_result["version"] != $this->__version) {
                    $v_result["version"] = $this->__version;
                    $v_result["data"] = $this->restructureWSArray(parent::__call($function_name,$arguments));
                }
                return $v_result["data"];
            } else {
                $result = $this->restructureWSArray(parent::__call($function_name, $arguments));
                $v_result = array();
                $v_result["version"] = $this->__version;
                $v_result["data"] = $result;
                $this->__cache[$cache_file_name] = $v_result;
                return $result;
            }
        } else {
            return $this->restructureWSArray(parent::__call($function_name, $arguments));
        }
    }

    private function restructureWSArray ($sectionQuestion_wsArray){

        $wsArrayTitles = $sectionQuestion_wsArray->columnList;
        $wsArrayData = $sectionQuestion_wsArray->data;

        $sectionQuestion_wsArray2 = array();

        foreach ($wsArrayData as $key=>$value) {
            $newArrayRow = array();
            foreach ($value as $key1=>$value1) {
                $newArrayRow[$wsArrayTitles[$key1]] = $value1;
            }
            $sectionQuestion_wsArray2[$key] = $newArrayRow;
        }

        return $sectionQuestion_wsArray2;
    }
}
?>