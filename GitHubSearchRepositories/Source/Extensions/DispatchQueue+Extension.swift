//
//  DispatchQueue+Extension.swift
//  GitHubSearchRepositories
//
//  Created by Koji Torishima on 2022/08/21.
//

import Foundation

extension DispatchQueue {
    func throttle(delay: DispatchTimeInterval) -> (_ action: @escaping () -> ()) -> Void {
        var lastFireTime: DispatchTime = .now()

        return { [weak self, delay] action in
            let deadline: DispatchTime = .now() + delay
            self?.asyncAfter(deadline: deadline) { [delay] in
                let now: DispatchTime = .now()
                let when: DispatchTime = lastFireTime + delay
                if now < when { return }
                lastFireTime = .now()
                action()
            }
        }
    }
    
    func debounce(delay: DispatchTimeInterval) -> (_ action: @escaping () -> ()) -> () {
        var lastFireTime: DispatchTime = .now()

        return { [weak self, delay] action in
            let deadline: DispatchTime = .now() + delay
            lastFireTime = .now()
            self?.asyncAfter(deadline: deadline) { [delay] in
                let now: DispatchTime = .now()
                let when: DispatchTime = lastFireTime + delay
                if now < when { return }
                lastFireTime = .now()
                action()
            }
        }
    }
}
