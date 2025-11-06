//
//  TermsOfUseView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.11.2025.
//

import SwiftUI

struct TermsOfUseView: View {
    var onAccept: () -> Void
    var onDecline: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Kullanım Koşulları")
                .font(.title)
                .bold()
            
            ScrollView {
                Text("""
                Bu uygulamayı kullanarak, aşağıdaki şartları kabul etmiş olursunuz:
                - Uygulama içeriğinde uygunsuz, saldırgan veya yasa dışı paylaşım yapılamaz.
                - Kullanıcılar arasında saygılı iletişim zorunludur.
                - Geliştirici, gerekli durumlarda kullanıcıyı engelleme veya içeriği kaldırma hakkına sahiptir.
                - Gizlilik politikamız kapsamında kişisel verileriniz yalnızca uygulama işlevleri için saklanır.
                """)
                .font(.body)
                .padding(.top, 10)
            }
            
            Spacer()
            
            HStack {
                Button("Reddet") {
                    onDecline()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
                Button("Kabul Et") {
                    onAccept()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("logoBlue"))
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
    }
}
