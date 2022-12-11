# Phishing Diagrams

```kroki-PlantUML
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Dynamic.puml

scale 900 width

LAYOUT_WITH_LEGEND()

ContainerDb(ml, "Machine Learning", "Traning Phishing Model", "phishing-url-resutl.json -> probe，true/false.phishing-url-result.json -> new phishing-model")

ContainerDb(v, "Vast", "Query URL", "Query Engine")

Container(c1, "Go Spider Application", "extracting relevant info", "phishing-features.json -> indicates.field")

Container_Boundary(c, "Python") {
  Component(c5, "Phishing.url.data", "parser data", "receive the data from the go.spider")
  Component(c6, "Phishing.url.result", "match indicates", "get phishing-url-result.json by python script")
  Component(c7, "done.phishing.result", "vast export json 'done.phishing.url.result.result == 0'", "get the result by the machine-learning model")
}

Container_Boundary(m, "Training DataSet") {
  Component(m1, "Phishing-url-result", "merge dataset", true.phishing.url.result.json")
  Component(m2, "Training model", "get model", "Through machine learning algorithms, we can generate relevant phishing indicates models through true.phishing.result dataset")
}
Rel_R(m2, c7, "generate model", "pick algorithm")
Rel_U(c1, v, "vast import -t phishing.url.data json", "import phishing.url.data")
Rel(c5, c6, "Phishing rules -> [0 1 -1]")
Rel(c6, c7, "result -> np.array")
Rel_U(ml, c7, "message model", "optimize algorithm")
Rel_D(m, v, "vast import -t phishing.url.result", "Vast Import")
Rel_R(v, ml, "vast export -n 1 arrow 'phishing.url.data.url == url", "Vast Export")
@enduml
```

- notebook [julia]: https://github.com/GTrunSec/data-science-threat-intelligence/blob/main/notebooks/Phishing.ipynb
