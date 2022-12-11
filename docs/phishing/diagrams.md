# Phishing Diagrams 



```kroki-PlantUML
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Dynamic.puml

scale 900 width

LAYOUT_WITH_LEGEND()

ContainerDb(ml, "Machine Learning", "Traning Phishing Model", "phishing-url-resutl.json -> probe，true.phishing-url-result.json -> new phishing-model")

ContainerDb(v, "Vast", "Query URL", "export dataset to vast.database")

Container(c1, "Go Spider Application", "extracting relevant info", "phishing-features.json -> indicates.field")

Container_Boundary(c, "Python") {
  Component(c5, "Phishing.url.data", "parser data", "receive the data from the go.spider")
  Component(c6, "Phishing.result", "match indicates", "get phishing-result.json by python script")
  Component(c7, "done.phishing.result", "phishing result", "get the result by the machine-learning model")
}

Container_Boundary(m, "Tranning DataSet") {
  Component(m1, "Phishing-url-result", "merge dataset", true.phishing.url.result.json")
  Component(m2, "Training model", "get model", "Through machine learning algorithms, we can generate relevant phishing indicates models through merged phishing.result data")
}
Rel_R(m2, c7, "generate model", "pick algorithm")
Rel_U(c1, c, "search phishing.url.data", "type == phishing.url.data")
Rel(c5, c6, "Phishing rules -> [0 1 -1]")
Rel(c6, c7, "result -> np.array")
Rel_U(ml, c7, "message model", "optimize algorithm")
Rel_D(m, v, "import json type == phishing-result", "Vast Import")
Rel_R(v, ml, "type == phishing && phishing.url == https://www.sascopw.com", "Vast Query")
@enduml
```


