//
//  ReadableContent.swift
//  AutoLayout
//
//  Created by Dariy Kutelov on 13.02.22.
//

import UIKit

class ReadableContent: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    
    private func setupViews() {
        let label = makeLabel(withText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed pulvinar viverra nibh, nec molestie elit iaculis in. Phasellus mattis arcu eu odio scelerisque, vel feugiat tortor mattis. Aliquam ultricies at dui ac semper. Pellentesque eu lorem velit. Nullam vitae libero iaculis, molestie nulla nec, commodo sapien. Nunc vitae quam non lorem rutrum semper sed in sem. Mauris ultricies hendrerit efficitur. Morbi ut feugiat quam. Vivamus porta cursus elit, vel tincidunt velit placerat vel. Integer ut arcu eget nisl interdum interdum sed sit amet lacus. Sed placerat dolor bibendum, cursus eros eget, fringilla velit. Fusce tempus ex non vulputate venenatis. Nunc malesuada porttitor enim a sollicitudin.\nInteger neque metus, mattis a dignissim at, fermentum ac risus. Vivamus eget luctus lacus. Nam ac tempus purus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec non dolor id est finibus blandit. Cras et gravida tortor. Aliquam augue nibh, interdum eu ullamcorper et, hendrerit non ligula. Nullam vel feugiat ligula, nec aliquet mauris.\nVestibulum et felis finibus, eleifend est at, malesuada velit. Donec egestas interdum nibh vitae porttitor. Donec lacus lectus, vestibulum eget ultricies quis, egestas vehicula diam. Quisque laoreet magna nisl, sed euismod erat luctus in. Vestibulum metus ipsum, bibendum non odio at, mattis varius tortor. Pellentesque at nunc condimentum, posuere lacus vitae, sagittis odio. Donec varius neque laoreet, vulputate nulla non, efficitur est. Quisque sit amet est posuere, fermentum orci id, dictum leo. Curabitur tempus enim neque, id dapibus augue semper at. Donec interdum, ligula at pellentesque ultricies, diam massa facilisis ligula, sit amet congue sapien leo nec leo. Nunc nec sem sit amet mi tempor vehicula. Donec et justo eget ex porttitor auctor sit amet vitae nisl.")
        
        view.addSubview(label)
        
        // Using layoutMarginsGuide
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
            label.bottomAnchor.constraint(equalTo:view.readableContentGuide.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
        ])
    }
    
    private func makeLabel(withText text: String) -> UILabel {
        let label = UILabel()
        
        // For auto layout to work
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = text
        label.textColor = .white
        label.backgroundColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }
    
}
