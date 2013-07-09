typedef enum {Undefined, Pending, Passed, Failed} DhirkinResult;
typedef enum {GivenStep, WhenStep, ThenStep, AndStep, ButStep, StarStep, UnknownStep} StepKeyword;
typedef enum {FeatureSection, ScenarioSection, ScenarioOutlineSection, ExampleSection, TagSection, UnknownSection} SectionKeyword;