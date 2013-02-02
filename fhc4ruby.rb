require 'net/http'
require 'uri'
require 'json'

class FHC
  class FHCResult < Hash
    def initialize(json_str)
      hash = JSON.parse(json_str)
      replace(hash)
    end

    def success?
      return (self["result"] == "ok")
    end

    def method_missing(name, *args)
      if self.include?(name.to_s)
        return self[name.to_s]
      end
      super
    end
  end # of FHCResult class

  def initialize(key, host, port=80)
    @key  = key
    @host = host
    @port = port.to_i

    @apikey_keyname = "webapi_apikey"
    Net::HTTP.version_1_2
  end

  def _call_fhc_api_get(api_path, opts={})
    if not api_path.include?(@apikey_keyname)
      api_path << "?#{@apikey_keyname}=#{@key}"
    end
    opts.each do |k, v|
      next if (k == @apikey_keyname)
      api_path << "&#{k}=#{URI.encode(v)}"
    end

    Net::HTTP.start(@host, @port) do |http|
      res = http.get(api_path)
      body_json = res.body
      return FHCResult.new(body_json)
    end
  end

  def getlist()
    api_path = "/api/elec/getlist"
    opt = {}
    return _call_fhc_api_get(api_path)
  end
  alias :get_list :getlist

  def getactionlist(kaden_name)
    api_path = "/api/elec/getactionlist"
    opt = {"elec" => kaden_name}
    return _call_fhc_api_get(api_path, opt)
  end
  alias :get_action_list :getactionlist

  def getinfo(kaden_name)
    api_path = "/api/elec/getinfo"
    opt = {"elec" => kaden_name}
    return _call_fhc_api_get(api_path, opt)
  end
  alias :get_info :getinfo

  def detaillist()
    api_path = "/api/elec/detaillist"
    opt = {}
    return _call_fhc_api_get(api_path, opt)
  end
  alias :detail_list     :detaillist
  alias :get_detail_list :detaillist

  def action(kaden_name, action_name)
    api_path = "/api/elec/action"
    opt = {"elec" => kaden_name, "action" => action_name}
    return _call_fhc_api_get(api_path, opt)
  end

  def get_sensor_raw()
    api_path = "/api/sensor/get"
    opt = {}
    return _call_fhc_api_get(api_path, opt)
  end

  def temp()
    api_path = "/api/sensor/get"
    opt = {}
    ret = _call_fhc_api_get(api_path, opt)
    return ret["temp"]
  end

  def lumi()
    api_path = "/api/sensor/get"
    opt = {}
    ret = _call_fhc_api_get(api_path, opt)
    return ret["lumi"]
  end

end

