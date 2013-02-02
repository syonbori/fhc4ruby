fhc4ruby
========

FutureHomeController controller for Ruby

## Target device
[Future Home Controller](http://rti-giken.jp/fhc/help/ref/setting_webapi.html)

## Sample
    API_KEY  = ""
    FHC_HOST = "fhc.example.com"
    FHC_PORT = 80

    fhc = FHC.new(API_KEY, FHC_HOST, FHC_PORT)

    ret = fhc.get_list
    if ret.success?
        puts ret.list
    end

    fhc.action("扇風機", "つける")

    puts "temperature: #{fhc.temp}"

## Licence
Copyright &copy; 2013 syonbori
Distributed under the MIT License.
