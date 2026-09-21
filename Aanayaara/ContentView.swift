import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            CosmicBackground()

            ScrollView {
                VStack(spacing: 28) {
                    BrandHeader()
                    FeaturedJourneyCard()
                    JourneySection()
                    ClosingQuote()
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 118)
            }
            .scrollIndicators(.hidden)
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            MainTabBar()
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
        }
        .preferredColorScheme(.dark)
    }
}

private struct CosmicBackground: View {
    var body: some View {
        GeometryReader { proxy in
            Image("himmelschronik")
                .resizable()
                .scaledToFill()
                .frame(width: proxy.size.width, height: proxy.size.height)
                .overlay(Color(red: 0.01, green: 0.03, blue: 0.16).opacity(0.63))
                .clipped()
                .ignoresSafeArea()
        }
        .ignoresSafeArea()
        .accessibilityHidden(true)
    }
}

private struct BrandHeader: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 2) {
                Image("aanayaara_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 132, height: 132)
                    .accessibilityHidden(true)

                Text("Aanayaara")
                    .font(.system(.largeTitle, design: .serif, weight: .regular))
                    .foregroundStyle(Color.aanayaaraIvory)
                    .minimumScaleFactor(0.8)

                Text("E I N E   R E I S E   D U R C H   D E N   H I M M E L")
                    .font(.caption2.weight(.medium))
                    .foregroundStyle(Color.aanayaaraLavender)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.65)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)

            Button(action: {}) {
                Image(systemName: "person")
                    .font(.title3.weight(.medium))
                    .foregroundStyle(Color.aanayaaraLavender)
                    .frame(width: 46, height: 46)
                    .background(Color.aanayaaraIndigo.opacity(0.72), in: Circle())
                    .overlay(Circle().stroke(Color.aanayaaraLavender.opacity(0.28)))
                    .shadow(color: .black.opacity(0.28), radius: 10, y: 5)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Profil öffnen")
        }
    }
}

private struct FeaturedJourneyCard: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("journal")
                .resizable()
                .scaledToFill()
                .frame(height: 330)
                .overlay {
                    LinearGradient(
                        colors: [.clear, Color.aanayaaraNight.opacity(0.22), Color.aanayaaraNight.opacity(0.96)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }

            VStack(alignment: .leading, spacing: 14) {
                Text("K A P I T E L  I")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(Color.aanayaaraLavender)

                Text("Der erste Schimmer")
                    .font(.system(.title, design: .serif, weight: .semibold))
                    .foregroundStyle(Color.aanayaaraIvory)

                Rectangle()
                    .fill(Color.aanayaaraGold)
                    .frame(width: 54, height: 1)

                Button(action: {}) {
                    HStack {
                        Text("Reise fortsetzen")
                            .font(.system(.headline, design: .serif, weight: .semibold))
                        Spacer(minLength: 12)
                        Image(systemName: "chevron.right")
                            .font(.headline)
                    }
                    .foregroundStyle(Color.aanayaaraNight)
                    .padding(.horizontal, 22)
                    .frame(maxWidth: 250, minHeight: 54)
                    .background(
                        LinearGradient(
                            colors: [Color.aanayaaraIvory, Color.aanayaaraGold],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        in: Capsule()
                    )
                    .overlay(Capsule().stroke(.white.opacity(0.72)))
                    .shadow(color: Color.aanayaaraGold.opacity(0.6), radius: 12)
                }
                .buttonStyle(.plain)
            }
            .padding(24)
        }
        .frame(height: 330)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(Color.aanayaaraLavender.opacity(0.55), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.34), radius: 22, y: 12)
    }
}

private struct JourneySection: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .firstTextBaseline) {
                Text("Deine Reise")
                    .font(.system(.title, design: .serif, weight: .medium))
                    .foregroundStyle(Color.aanayaaraIvory)

                Spacer()

                Text("W O R T E .  S T E R N E .  D U .")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(Color.aanayaaraLavender)
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
            }

            HStack(spacing: 12) {
                JourneyCard(
                    imageName: "himmelschronik",
                    symbol: "sparkles",
                    title: "Himmelschronik",
                    subtitle: "ENTDECKE DIE GESCHICHTE"
                )

                JourneyCard(
                    imageName: "journal",
                    symbol: "pencil.tip",
                    title: "Journal",
                    subtitle: "DEINE GEDANKEN\nIM UNIVERSUM"
                )
            }
        }
    }
}

private struct JourneyCard: View {
    let imageName: String
    let symbol: String
    let title: LocalizedStringResource
    let subtitle: LocalizedStringResource

    var body: some View {
        Button(action: {}) {
            ZStack(alignment: .bottomLeading) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 210)
                    .overlay {
                        LinearGradient(
                            colors: [.clear, Color.aanayaaraNight.opacity(0.9)],
                            startPoint: .center,
                            endPoint: .bottom
                        )
                    }

                VStack(alignment: .leading, spacing: 7) {
                    Image(systemName: symbol)
                        .font(.title3)
                        .foregroundStyle(Color.aanayaaraGold)
                        .frame(width: 46, height: 46)
                        .background(Color.aanayaaraIndigo.opacity(0.7), in: Circle())
                        .overlay(Circle().stroke(Color.aanayaaraGold, lineWidth: 1.2))
                        .shadow(color: Color.aanayaaraGold.opacity(0.38), radius: 8)

                    HStack(spacing: 6) {
                        Text(title)
                            .font(.system(.headline, design: .serif, weight: .semibold))
                            .foregroundStyle(Color.aanayaaraIvory)
                            .lineLimit(1)
                            .minimumScaleFactor(0.72)

                        Spacer(minLength: 0)

                        Image(systemName: "chevron.right")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(Color.aanayaaraLavender)
                    }

                    Text(subtitle)
                        .font(.system(size: 9, weight: .semibold))
                        .tracking(1.25)
                        .foregroundStyle(Color.aanayaaraLavender)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                }
                .padding(16)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 210)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .stroke(Color.aanayaaraLavender.opacity(0.55), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .combine)
    }
}

private struct ClosingQuote: View {
    var body: some View {
        HStack(spacing: 14) {
            Rectangle()
                .fill(Color.aanayaaraLavender.opacity(0.7))
                .frame(height: 1)

            Text("Manche Geschichten findet man nicht.\nSie finden dich.")
                .font(.system(.callout, design: .serif).italic())
                .foregroundStyle(Color.aanayaaraLavender)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)

            Rectangle()
                .fill(Color.aanayaaraLavender.opacity(0.7))
                .frame(height: 1)
        }
    }
}

private struct MainTabBar: View {
    var body: some View {
        HStack {
            TabItem(title: "Reise", symbol: "planet", isSelected: true)
            TabItem(title: "Chronik", symbol: "sparkles", isSelected: false)
            TabItem(title: "Journal", symbol: "pencil", isSelected: false)
        }
        .padding(.horizontal, 10)
        .frame(height: 78)
        .background(.ultraThinMaterial, in: Capsule())
        .background(Color.aanayaaraIndigo.opacity(0.55), in: Capsule())
        .overlay(Capsule().stroke(Color.aanayaaraLavender.opacity(0.3)))
        .shadow(color: .black.opacity(0.35), radius: 18, y: 9)
    }
}

private struct TabItem: View {
    let title: LocalizedStringResource
    let symbol: String
    let isSelected: Bool

    var body: some View {
        Button(action: {}) {
            VStack(spacing: 5) {
                Image(systemName: symbol)
                    .font(.title2)
                    .symbolEffect(.pulse, value: isSelected)

                Text(title)
                    .font(.caption)

                Circle()
                    .frame(width: 5, height: 5)
                    .opacity(isSelected ? 1 : 0)
            }
            .foregroundStyle(isSelected ? Color.aanayaaraGold : Color.aanayaaraLavender)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

private extension Color {
    static let aanayaaraNight = Color(red: 0.015, green: 0.025, blue: 0.12)
    static let aanayaaraIndigo = Color(red: 0.08, green: 0.08, blue: 0.25)
    static let aanayaaraLavender = Color(red: 0.69, green: 0.65, blue: 1.0)
    static let aanayaaraIvory = Color(red: 1.0, green: 0.96, blue: 0.84)
    static let aanayaaraGold = Color(red: 1.0, green: 0.76, blue: 0.34)
}

#Preview {
    ContentView()
}
