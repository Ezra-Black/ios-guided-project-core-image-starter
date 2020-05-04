import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins
import Photos

class PhotoFilterViewController: UIViewController {
    
    let context = CIContext(options: nil)
    var originalImage: UIImage? {
        didSet {
            updateViews()
        }
    }

	@IBOutlet weak var brightnessSlider: UISlider!
	@IBOutlet weak var contrastSlider: UISlider!
	@IBOutlet weak var saturationSlider: UISlider!
	@IBOutlet weak var imageView: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
        let filter = CIFilter(name: "CIColorControls")! //Built in filter.
        print(filter)
        print(filter.attributes)
        //demo purposes
        originalImage = imageView.image
	}
    
    
    //    stub with default return.
    private func filterImage(_ image: UIImage) -> UIImage? {
        
        //UIImage -> CGImage -> CIImage
        guard let cgImage = image.cgImage else {return nil}
        let ciImage = CIImage(cgImage: cgImage)
        
        
        let filter = CIFilter(name: "CIColorControls")!
        //built in filtering.
//        let filter2 = CIFilter.colorControls()
//        filter2.brightness = 3
//        filter2.brightness = brightnessSlider.value
        filter.setValue(ciImage, forKey: kCIInputImageKey) //"inputImage"
        filter.setValue(saturationSlider.value, forKey: kCIInputSaturationKey)
        filter.setValue(brightnessSlider.value, forKey: kCIInputBrightnessKey)
        filter.setValue(contrastSlider.value, forKey: kCIInputContrastKey)
        //CIImage -> CGImage -> UIImage
        guard let outputCIImage = filter.outputImage else {return nil}
        //render the image
        guard let outputCGImage = context.createCGImage(outputCIImage,
                                                        from: CGRect(origin: .zero,
                                                                     size: image.size)) else {return nil}
        return UIImage(cgImage: outputCGImage)
    }
    
    private func updateViews() {
        if let originalImage = originalImage {
            imageView.image = filterImage(originalImage)
        } else {
            imageView.image = nil
        }
    }
    
	// MARK: Actions
	
	@IBAction func choosePhotoButtonPressed(_ sender: Any) {
		// TODO: show the photo picker so we can choose on-device photos
		// UIImagePickerController + Delegate
	}
	
	@IBAction func savePhotoButtonPressed(_ sender: UIButton) {
		// TODO: Save to photo library
	}
	

	// MARK: Slider events
	
	@IBAction func brightnessChanged(_ sender: UISlider) {
        updateViews()
	}
	
	@IBAction func contrastChanged(_ sender: Any) {
        updateViews()
	}
	
	@IBAction func saturationChanged(_ sender: Any) {
        updateViews()
	}
}

