
@clusters = {
  "manager" => { 
    :box_image => "generic/ubuntu1804", 
    :ip => "192.168.10.10", 
    :mem => 1024,
    :script => "./script.sh", # instalar docker
    # :folder => "./app", # pra depois
  },
  "node1" => { 
    :box_image => "generic/ubuntu1804",
    :ip => "192.168.10.11",
    :mem => 1024,
    :script => "./script.sh",
  },
  "node2" => { 
    :box_image => "generic/ubuntu1804",
    :ip => "192.168.10.12", 
    :mem => 1024,
    :script => "./script.sh",
  }
}