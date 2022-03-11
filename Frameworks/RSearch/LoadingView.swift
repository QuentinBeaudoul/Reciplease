//
//  LoadingView.swift
//  RSearch
//
//  Created by Quentin on 11/03/2022.
//

import LoadableViews

class LoadingView: LoadableView {

    func show() {
        alpha = 0
        UIView.animate(withDuration: 0.3) { [self] in
            alpha = 1.0
        }
        isHidden = false
    }

    func hide() {
        isHidden = true
    }
}
