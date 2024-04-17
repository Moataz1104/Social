//
//  AddUserInfoCell.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 15/04/2024.
//

import UIKit

class AddUserInfoCell: UICollectionViewCell {
    static let identifier = "AddUserInfoCell"
    var selectedImage:UIImage?
    
    @IBOutlet weak var chooseImage : UIImageView!
    @IBOutlet weak var userName : UITextField!
    @IBOutlet weak var userBio : UITextField!
    @IBOutlet weak var saveButton:UIButton!
    @IBOutlet weak var logOutButton:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImageTapped))
        chooseImage.isUserInteractionEnabled = true
        chooseImage.addGestureRecognizer(tapGesture)

    }
    
//    MARK: - Actions
        
    @objc func chooseImageTapped() {
        showImagePicker()
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        ImageSelectionManager.shared.selectedImage = selectedImage

    }
    
    
    
    //    MARK: - privates
    
    private func configUI(){
        chooseImage.layer.borderWidth = 1
        chooseImage.layer.cornerRadius = chooseImage.bounds.width / 2
        chooseImage.clipsToBounds = true
        
        
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
        logOutButton.layer.cornerRadius = logOutButton.frame.height / 2
        
        
    }
    private func showImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            DispatchQueue.main.async {
                self.window?.rootViewController?.present(picker, animated: true, completion: nil)
            }
        }
    }

    
}

extension AddUserInfoCell : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            chooseImage.image = image
            chooseImage.contentMode = .scaleAspectFill
            selectedImage = image

        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            chooseImage.image = image
            chooseImage.contentMode = .scaleAspectFill
            selectedImage = image

        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
