import 'package:tflite/tflite.dart';

class ImageClassifier {
  // Load the model
  Future<String?> loadModel() async {
    String? res = await Tflite.loadModel(
      model: "lib/model/trained_plant_disease_model.tflite",
      // labels: "lib/model/labels.txt", // Uncomment if you have a labels file
    );
    print(res != null ? 'Model loaded successfully' : 'Error loading model');
    return res;
  }

  // Classify the image using the model
  Future<List> classifyImage(String imagePath) async {
    print("Running model on image: $imagePath"); // Debugging

    var output = await Tflite.runModelOnImage(
      path: imagePath,
      numResults: 2, // Set based on the number of labels your model outputs
      threshold: 0.5, // Set an appropriate threshold for predictions
    );

    print("Model output: $output"); // Debugging
    return output ?? [];
  }

  // Close the model when you're done
  Future<void> close() async {
    await Tflite.close();
  }
}
