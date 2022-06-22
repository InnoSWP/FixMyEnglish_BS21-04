import 'package:FixMyEnglish/mistake.dart';

var mistakes = [
  Mistake(match: "n't",
      sentence: "This solution isn't the most effective one.",
      label: "SPOKN1",
      description: "Using contractions"
  ),
  Mistake(match: "There are",
      sentence: "There are three ways to solve this problem.",
      label: "SPOKN1",
      description: "Using forms of there is/are"
  ),
  Mistake(match: "good",
      sentence: "this is good.",
      label: "VOCAB5",
      description: "using a forbidden words"
  ),
  Mistake(
      match: "Also",
      sentence: "Also, React Native provides complete access to the device hardware, such as the camera, file system, Bluetooth, etc.",
      label: "VOCAB5",
      description: "using a forbidden words"
  ),
  Mistake(
    match: "and so on",
    sentence: "React Native provides complete access to the device hardware, such as the camera, file system, Bluetooth, and so on.",
    label: "SPOKN1",
    description: "Preferring and so on to etc.",
  ),
  Mistake(
      match: "for model",
      sentence: "The process of data generation is explained with the following planIn this section, I explain the software tools, libraries, and frameworks used for model development.",
      label: "WORDNES3",
      description: "Describing purpose through the use of for + noun or for + gerund"
  )
];