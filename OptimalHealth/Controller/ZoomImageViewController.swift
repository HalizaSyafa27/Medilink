import UIKit

class ZoomImageViewController: UIViewController, UIScrollViewDelegate {
    var selectedImage: UIImage? // Gambar yang akan ditampilkan
    @IBOutlet weak var imageView: UIImageView!
    
    private let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupScrollView()
        setupImageView()
//        setupGestures()
        if let image = selectedImage {
                   imageView.image = image
            setupGestures()
            setupScrollView()
                   print("Gambar berhasil ditampilkan di ZoomImageViewController")
               } else {
                   print("ERROR: selectedImage nil!")
               }
    }
    
    // MARK: - Setup ScrollView
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0 // Bisa diubah jika perlu zoom lebih besar
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)

        // Auto Layout agar scrollView memenuhi layar
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Setup ImageView
    private func setupImageView() {
        guard let image = selectedImage else {
            print("ERROR: selectedImage nil di ZoomImageViewController")
            return
        }

        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        scrollView.addSubview(imageView)

        // Atur ukuran imageView sesuai dengan gambar asli
        let imageSize = image.size
        let screenWidth = view.bounds.width
        let screenHeight = view.bounds.height
        let aspectRatio = imageSize.width / imageSize.height
        
        var finalWidth = screenWidth
        var finalHeight = screenWidth / aspectRatio
        
        if finalHeight > screenHeight {
            finalHeight = screenHeight
            finalWidth = screenHeight * aspectRatio
        }
        
        imageView.frame = CGRect(x: 0, y: 0, width: finalWidth, height: finalHeight)
        scrollView.contentSize = imageView.frame.size

        // Pastikan gambar di tengah saat pertama kali muncul
        centerImageView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        centerImageView()
    }

    // MARK: - Setup Gestures
    private func setupGestures() {
        // Gesture untuk keluar (single tap)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        // Gesture untuk double tap zoom
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
        
        // Gesture untuk pinch zoom (tambahan)
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        view.addGestureRecognizer(pinchGesture)

        // Agar single tap tidak bentrok dengan double tap
        tapGesture.require(toFail: doubleTapGesture)
    }
    
    // MARK: - Gesture Actions
    @objc func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1.0 {
            let zoomRect = zoomRectForScale(scale: scrollView.maximumZoomScale, center: sender.location(in: imageView))
            scrollView.zoom(to: zoomRect, animated: true)
        } else {
            scrollView.setZoomScale(1.0, animated: true)
        }
    }

    @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        scrollView.setZoomScale(scale * scrollView.zoomScale, animated: false)
        sender.scale = 1.0
    }

    private func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        let width = scrollView.frame.width / scale
        let height = scrollView.frame.height / scale
        let x = center.x - (width / 2.0)
        let y = center.y - (height / 2.0)
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    // MARK: - Zoom Handling
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImageView()
    }

    private func centerImageView() {
        let xOffset = max(0, (scrollView.bounds.width - imageView.frame.width) / 2)
        let yOffset = max(0, (scrollView.bounds.height - imageView.frame.height) / 2)
        imageView.frame.origin = CGPoint(x: xOffset, y: yOffset)
    }

    // MARK: - Dismiss View
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
