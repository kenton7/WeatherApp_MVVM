//
//  Extensions.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import Foundation
import UIKit

//MARK: - UIColor
extension UIColor {
    static var tabBarItemSelected: UIColor = .white
    static var backgroundColorTabBar: UIColor = UIColor(red: 0.322, green: 0.239, blue: 0.498, alpha: 1)
    static var mainWhite: UIColor = .white
    static var tabBarItemNonSelected: UIColor = .gray
}

//MARK: - UIImage
extension UIImage {
    /// Функция для добавления круга на зданий фон картнки
    /// - Parameter color: цвет круга
    /// - Returns: картинка с кругом на заднем фоне
    func addBackgroundCircle(_ color: UIColor?) -> UIImage? {

        let circleDiameter = max(size.width * 2, size.height * 2)
        let circleRadius = circleDiameter * 0.5
        let circleSize = CGSize(width: circleDiameter, height: circleDiameter)
        let circleFrame = CGRect(x: 0, y: 0, width: circleSize.width, height: circleSize.height)
        let imageFrame = CGRect(x: circleRadius - (size.width * 0.5), y: circleRadius - (size.height * 0.5), width: size.width, height: size.height)

        let view = UIView(frame: circleFrame)
        view.backgroundColor = color ?? .systemRed
        view.layer.cornerRadius = circleDiameter * 0.5

        UIGraphicsBeginImageContextWithOptions(circleSize, false, UIScreen.main.scale)

        let renderer = UIGraphicsImageRenderer(size: circleSize)
        let circleImage = renderer.image { ctx in
            view.drawHierarchy(in: circleFrame, afterScreenUpdates: true)
        }

        circleImage.draw(in: circleFrame, blendMode: .normal, alpha: 1.0)
        draw(in: imageFrame, blendMode: .normal, alpha: 1.0)

        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image
    }
}

//MARK: - String
extension String {
    
    /// Функция для регулировки описания погоды, если в описании погоды 2 и более слова, так как с сервера приходит каждое слово с большой буквы
    /// - Parameter info: описание погоды (например, Облачно с прояснениями)
    /// - Returns: измененное значение
    func configureWeatherDescription(info: String) -> String {
        
        var finalStr = ""
        let separatedDescription = info.components(separatedBy: " ")
        let finalDescription = "\(separatedDescription[0].capitalized )\n\(separatedDescription.last ?? "")"
        
        if separatedDescription.count == 2 {
            finalStr = finalDescription
        } else if separatedDescription.count == 3 {
            finalStr = "\(separatedDescription[0].capitalized ) \(separatedDescription[1] )\n\(separatedDescription.last ?? "")"
        } else {
            finalStr = info.prefix(1).uppercased() + (info.lowercased().dropFirst())
        }
        
        return finalStr
    }
    
    func capitalizingFirstLetter() -> String {
       return prefix(1).uppercased() + self.lowercased().dropFirst()
     }

     mutating func capitalizeFirstLetter() {
       self = self.capitalizingFirstLetter()
     }
}

//MARK: - UIView
extension UIView {
    
    func animateImages(imageView1: UIImageView, imageView2: UIImageView, view: UIView) {
        UIView.animate(withDuration: 5.0, delay: 0.0, options: [.curveLinear]) {
            imageView1.frame = imageView1.frame.offsetBy(dx: -view.frame.size.width, dy: 0)
            imageView2.frame = imageView2.frame.offsetBy(dx: -view.frame.size.width, dy: 0)
        } completion: { _ in
            //                /*
            //                 Данный участок кода отвечает за проверку позиции изображений backgroundImageView1 и backgroundImageView2 по оси X после анимации.
            //                 Если позиция по оси X уходит за пределы отрицательного значения, что означает,
            //                 что изображение полностью ушло за границы видимой области влево,
            //                 то его положение сбрасывается на начальное положение.
            //
            //                 Рассмотрим подробнее:
            //                 backgroundImageView1.frame.origin.x - это текущая координата X (горизонтальная позиция) для backgroundImageView1.
            //                 backgroundImageView2.frame.origin.x - это текущая координата X (горизонтальная позиция) для backgroundImageView2.
            //                 imageViewWidth - это ширина видимой области (ширина экрана или контейнера для анимации).
            //                 Таким образом, если backgroundImageView1 или backgroundImageView2 выходят за левую границу видимой области
            //                 (то есть их X-координата меньше или равна -imageViewWidth), их положение сбрасывается на imageViewWidth,
            //                 чтобы создать эффект бесшовного движения. Это позволяет изображению переместиться "вне экрана"
            //                 и мгновенно вернуться на начальное положение, создавая иллюзию непрерывного движения.
            //                 */
            if imageView1.frame.origin.x <= -view.frame.size.width {
                imageView1.frame.origin.x = view.frame.size.width
            }
            if imageView2.frame.origin.x <= -view.frame.size.width {
                imageView2.frame.origin.x = view.frame.size.width
            }
            self.animateImages(imageView1: imageView1, imageView2: imageView2, view: view)
        }
    }
    
    func animateBackground(image: UIImage, on view: UIView) {
        guard let imageView1 = view.viewWithTag(100) as? UIImageView,
              let imageView2 = view.viewWithTag(101) as? UIImageView else {
            let imageView1 = UIImageView(image: image)
            let imageView2 = UIImageView(image: image)
            imageView1.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            imageView1.tag = 100
            view.insertSubview(imageView1, at: 0)
            imageView2.frame = CGRect(x: view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            imageView2.transform = CGAffineTransform(scaleX: -1, y: 1)
            imageView2.tag = 101
            view.insertSubview(imageView2, at: 0)
            
            animateImages(imageView1: imageView1, imageView2: imageView2, view: view)
            return
        }
    }
}
