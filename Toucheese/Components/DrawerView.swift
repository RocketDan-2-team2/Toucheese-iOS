//
//  DrawerView.swift
//  Toucheese
//
//  Created by SunJoon Lee on 12/19/24.
//

import SwiftUI

struct DrawerView<Content: View, DrawerContent: View>: View {
    
    /// DrawerContent가 멈춰있을때 Offset을 나타내는 변수
    @State private var stoppedOffset = CGSize.zero
    
    /// 현재 DrawerContent의 Offset을 나타내는 변수
    @State private var currentOffset = CGSize.zero
    
    /// .onAppear() 단계에서 DrawerContent가 이동하는걸 보여주지 않도록 하는 변수
    @State private var isSetDrawer = false
    
    /// DrawerContent가 On / Off 인지를 나타내는 변수
    ///
    /// `true`라면 DrawerContent가 보여진다. (On 상태)
    ///
    /// `false`라면 DrawerContent가 보여지지 않는다. (Off 상태)
    @Binding var isShowingDrawer: Bool
    
    /// DrawView의 전체 화면을 기준으로 DrawerContent의 비율
    ///
    /// 0.7인 경우, DrawerContent의 너비가 DrawView의 화면의 0.7 정도가 된다.
    ///
    /// 반드시 0 이상 1 이하의 값을 갖도록 한다.
    ///
    /// 기본값은 1.0이다.
    let drawerWidthRate: CGFloat
    
    /// DrawerContent가 On이 된 상태에서, DrawerContent 더 크게 만들려고 움직일 때, 최대로 얼만큼 움직이게 할 수 있는지 정해주는 비율이다.
    ///
    /// DrawerContent의 너비를 기준으로 한다.
    ///
    /// 0.1을 써준 경우, DrawerContent 너비의 10%정도를 더 드래그할 수 있다. (다시 On상태로 돌아온다.)
    ///
    /// 반드시 0 이상 1 이하의 값을 갖도록 한다.
    ///
    /// 기본값은 0.05이다.
    let drawerMaxRate: CGFloat
    
    /// DrawerContent가 On / Off 인지 기준이 되는 비율 (DrawerContent의 화면 크기에 따라)
    ///
    /// 값이 0.8인 경우, DrawerContent의 80% 이상보다 안보일 경우 (20%가 가려졌을 경우) DrawerContent가 Off가 된다.
    ///
    /// 반대로 80% 이상이 보일 경우, DrawerContent가 On이 된다.
    ///
    /// 반드시 0 이상 1 이하의 값을 갖도록 한다.
    ///
    /// 기본값은 0.5이다.
    let standardRate: CGFloat
    
    /// 기존에 사용하는 뷰
    let content: Content
    /// Drawer로 사용하는 뷰
    let drawerContent: DrawerContent
    
    init(
        isShowingDrawer: Binding<Bool>,
        drawerWidthRate: CGFloat = 1.0,
        drawerMaxRate: CGFloat = 0.08,
        standardRate: CGFloat = 0.5,
        @ViewBuilder content: () -> Content,
        @ViewBuilder drawerContent: () -> DrawerContent
    ) {
        self._isShowingDrawer = isShowingDrawer
        self.drawerWidthRate = drawerWidthRate
        self.drawerMaxRate = drawerMaxRate
        self.standardRate = standardRate
        self.content = content()
        self.drawerContent = drawerContent()
    }
    
    var body: some View {
        ZStack {
            // content
            self.content
            
            GeometryReader { proxy in
                
                // 화면 너비
                let screenWidth = proxy.size.width
                
                // Drawer 너비
                let drawerWidth = screenWidth * drawerWidthRate
                
                // Drawer 최대 너비
                let drawerMaxWidth = drawerWidth * (1 + drawerMaxRate)
                
                // Drawer가 On일때, x좌표 위치
                let drawerOnPositionX = screenWidth - drawerWidth
                
                // Drawer가 Off일때, x좌표 위치
                let drawerOffPositionX = screenWidth
                
                // Drawer On/Off의 기준 x좌표
                let standardPositionX
                    = drawerOffPositionX - (drawerWidth * standardRate)
                
                // Drawer의 최대 x좌표
                let maxPositionX = screenWidth - drawerMaxWidth
                
                // Drawer 그 자체
                ZStack(alignment: .leading) {
                    if isSetDrawer {
                        // Drawer Background
                        Rectangle()
                            .fill(.background)
                            .frame(
                                width: drawerMaxWidth,
                                height: proxy.size.height
                            )
                        
                        // Drawer Content
                        self.drawerContent
                            .frame(width: drawerWidth, height: proxy.size.height)
                    }
                }
                
                // Drawer의 Offset(위치)
                .offset(currentOffset)
                
                // Drawer의 Offset 초기화
                .onAppear {
                    if isShowingDrawer {
                        currentOffset.width = drawerOnPositionX
                        stoppedOffset.width = drawerOnPositionX
                    } else {
                        currentOffset.width = drawerOffPositionX
                        stoppedOffset.width = drawerOffPositionX
                    }
                    
                    // 초기화가 완료되면 Drawer가 보여짐
                    isSetDrawer = true
                }
                
                // Drawer의 On/Off Bool에 따라 위치 변경 및 애니메이션 적용
                .onChange(of: isShowingDrawer) {
                    if isShowingDrawer {
                        currentOffset.width = drawerOnPositionX
                        stoppedOffset.width = drawerOnPositionX
                    } else {
                        currentOffset.width = drawerOffPositionX
                        stoppedOffset.width = drawerOffPositionX
                    }
                }
                
                // 드래그 제스쳐
                .gesture(
                    DragGesture()
                    
                        // 드래그 함에 따라 변화하는 상태를 나타내는 클로저
                        .onChanged { dragValue in
                            currentOffset.width
                            = stoppedOffset.width + dragValue.translation.width
                            
                            // 최대로 드래그할 수 있는 범위 지정
                            if currentOffset.width < maxPositionX {
                                currentOffset.width = maxPositionX
                            }
                        }
                    
                        // 드래그가 끝나고(완료되고) 상태를 나타내는 클로저
                        .onEnded { _ in
                            
                            // 기준보다 offset이 크면 Drawer는 Off 상태
                            if standardPositionX < currentOffset.width {
                                stoppedOffset.width = drawerOffPositionX
                                isShowingDrawer = false
                                
                                // 기준보다 offset이 작으면 Drawer는 On 상태
                            } else {
                                stoppedOffset.width = drawerOnPositionX
                                isShowingDrawer = true
                            }
                            
                            // 현재 Offset으로 변경
                            currentOffset = stoppedOffset
                        }
                )
                .animation(Animation.easeInOut.speed(2), value: currentOffset)
            }
        }
    }
}

#Preview {
    DrawerView(isShowingDrawer: .constant(true)) {
        Color.black
    } drawerContent: {
        Color.red
    }

}
