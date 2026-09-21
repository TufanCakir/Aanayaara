import SwiftUI

private enum AppSection: Hashable {
    case journey
    case chronicle
    case journal
}

private enum AppRoute: Hashable {
    case chapter
    case chronicle
    case journal
    case settings
}

struct ContentView: View {
    @State private var selectedSection: AppSection = .journey
    @State private var localization = LocalizationStore()

    var body: some View {
        NavigationStack {
            Group {
                switch selectedSection {
                case .journey:
                    JourneyHome()
                case .chronicle:
                    ChronicleScreen()
                case .journal:
                    JournalScreen()
                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .chapter:
                    ChapterScreen()
                case .chronicle:
                    ChronicleScreen()
                case .journal:
                    JournalScreen()
                case .settings:
                    SettingsScreen()
                }
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                MainTabBar(selection: $selectedSection)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 8)
            }
            .tint(Color.aanayaaraGold)
            .background {
                CosmicBackground()
            }
        }
        .environment(localization)
        .preferredColorScheme(.dark)
    }
}

private struct JourneyHome: View {
    var body: some View {
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
}

private struct CosmicBackground: View {
    var body: some View {
        Image("himmelschronik")
            .resizable()
            .scaledToFill()
            .overlay(Color(red: 0.01, green: 0.03, blue: 0.16).opacity(0.63))
            .clipped()
            .accessibilityHidden(true)
            .ignoresSafeArea()
    }
}

private struct BrandHeader: View {
    @Environment(LocalizationStore.self) private var localization

    var body: some View {
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

            Text(localization.text("brand.tagline"))
                .font(.caption2.weight(.medium))
                .foregroundStyle(Color.aanayaaraLavender)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.65)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .topTrailing) {
            NavigationLink(value: AppRoute.settings) {
                Image(systemName: "gear")
                    .font(.title3.weight(.medium))
                    .foregroundStyle(Color.aanayaaraLavender)
                    .frame(width: 46, height: 46)
                    .background(
                        Color.aanayaaraIndigo.opacity(0.72),
                        in: Circle()
                    )
                    .overlay(
                        Circle().stroke(Color.aanayaaraLavender.opacity(0.28))
                    )
                    .shadow(color: .black.opacity(0.28), radius: 10, y: 5)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(localization.text("accessibility.openSettings"))
        }
    }
}

private struct FeaturedJourneyCard: View {
    @Environment(LocalizationStore.self) private var localization

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(localization.text("chapter.eyebrow"))
                .font(.caption.weight(.medium))
                .foregroundStyle(Color.aanayaaraLavender)

            Text(localization.text("chapter.title"))
                .font(.system(.title, design: .serif, weight: .semibold))
                .foregroundStyle(Color.aanayaaraIvory)

            Rectangle()
                .fill(Color.aanayaaraGold)
                .frame(width: 54, height: 1)

            NavigationLink(value: AppRoute.chapter) {
                HStack {
                    Text(localization.text("chapter.continue"))
                        .font(
                            .system(
                                .headline,
                                design: .serif,
                                weight: .semibold
                            )
                        )
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
        .frame(maxWidth: .infinity, minHeight: 330, alignment: .bottomLeading)
        .background {
            Image("journal")
                .resizable()
                .scaledToFill()
                .overlay {
                    LinearGradient(
                        colors: [
                            .clear, Color.aanayaaraNight.opacity(0.22),
                            Color.aanayaaraNight.opacity(0.96),
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
        }
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(Color.aanayaaraLavender.opacity(0.55), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.34), radius: 22, y: 12)
    }
}

private struct JourneySection: View {
    @Environment(LocalizationStore.self) private var localization

    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .firstTextBaseline) {
                Text(localization.text("journey.title"))
                    .font(.system(.title, design: .serif, weight: .medium))
                    .foregroundStyle(Color.aanayaaraIvory)

                Spacer()

                Text(localization.text("journey.motto"))
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(Color.aanayaaraLavender)
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
            }

            HStack(spacing: 12) {
                JourneyCard(
                    imageName: "himmelschronik",
                    symbol: "sparkles",
                    title: localization.text("chronicle.title"),
                    subtitle: localization.text("chronicle.cardSubtitle"),
                    route: .chronicle
                )

                JourneyCard(
                    imageName: "journal",
                    symbol: "pencil.tip",
                    title: localization.text("journal.title"),
                    subtitle: localization.text("journal.cardSubtitle"),
                    route: .journal
                )
            }
        }
    }
}

private struct JourneyCard: View {
    let imageName: String
    let symbol: String
    let title: String
    let subtitle: String
    let route: AppRoute

    var body: some View {
        NavigationLink(value: route) {
            VStack(alignment: .leading, spacing: 7) {
                Image(systemName: symbol)
                    .font(.title3)
                    .foregroundStyle(Color.aanayaaraGold)
                    .frame(width: 46, height: 46)
                    .background(
                        Color.aanayaaraIndigo.opacity(0.7),
                        in: Circle()
                    )
                    .overlay(
                        Circle().stroke(Color.aanayaaraGold, lineWidth: 1.2)
                    )
                    .shadow(color: Color.aanayaaraGold.opacity(0.38), radius: 8)

                HStack(spacing: 6) {
                    Text(title)
                        .font(
                            .system(
                                .headline,
                                design: .serif,
                                weight: .semibold
                            )
                        )
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
            .frame(maxWidth: .infinity)
            .frame(minHeight: 210, alignment: .bottomLeading)
            .background {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .overlay {
                        LinearGradient(
                            colors: [
                                .clear, Color.aanayaaraNight.opacity(0.9),
                            ],
                            startPoint: .center,
                            endPoint: .bottom
                        )
                    }
            }
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
    @Environment(LocalizationStore.self) private var localization

    var body: some View {
        HStack(spacing: 14) {
            Rectangle()
                .fill(Color.aanayaaraLavender.opacity(0.7))
                .frame(height: 1)

            Text(localization.text("journey.quote"))
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
    @Environment(LocalizationStore.self) private var localization
    @Binding var selection: AppSection

    var body: some View {
        HStack {
            TabItem(
                title: localization.text("tab.journey"),
                symbol: "planet",
                usesAsset: true,
                isSelected: selection == .journey,
                action: { selection = .journey }
            )
            TabItem(
                title: localization.text("tab.chronicle"),
                symbol: "sparkle",
                isSelected: selection == .chronicle,
                action: { selection = .chronicle }
            )
            TabItem(
                title: localization.text("tab.journal"),
                symbol: "pencil",
                isSelected: selection == .journal,
                action: { selection = .journal }
            )
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
    let title: String
    let symbol: String
    var usesAsset = false
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 5) {
                if usesAsset {
                    Image(symbol)
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 29, height: 29)
                } else {
                    Image(systemName: symbol)
                        .font(.title2)
                        .symbolEffect(.pulse, value: isSelected)
                }

                Text(title)
                    .font(.caption)

                Circle()
                    .frame(width: 5, height: 5)
                    .opacity(isSelected ? 1 : 0)
            }
            .foregroundStyle(
                isSelected ? Color.aanayaaraGold : Color.aanayaaraLavender
            )
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

private struct ChapterScreen: View {
    @Environment(LocalizationStore.self) private var localization

    var body: some View {
        CosmicDetailScreen(
            imageName: "journal",
            eyebrow: localization.text("chapter.eyebrow"),
            title: localization.text("chapter.title"),
            text: localization.text("chapter.description")
        )
        .navigationTitle(localization.text("tab.journey"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct ChronicleScreen: View {
    @Environment(LocalizationStore.self) private var localization

    var body: some View {
        CosmicDetailScreen(
            imageName: "himmelschronik",
            eyebrow: localization.text("chronicle.eyebrow"),
            title: localization.text("chronicle.heading"),
            text: localization.text("chronicle.description")
        )
        .navigationTitle(localization.text("tab.chronicle"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct JournalScreen: View {
    @Environment(LocalizationStore.self) private var localization
    @State private var entry = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                ScreenHeader(
                    eyebrow: localization.text("journal.eyebrow"),
                    title: localization.text("journal.title"),
                    text: localization.text("journal.description")
                )

                TextEditor(text: $entry)
                    .scrollContentBackground(.hidden)
                    .font(.body)
                    .foregroundStyle(Color.aanayaaraIvory)
                    .padding(14)
                    .frame(minHeight: 220)
                    .background(Color.aanayaaraIndigo.opacity(0.72))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .stroke(Color.aanayaaraLavender.opacity(0.5))
                    }
                    .overlay(alignment: .topLeading) {
                        if entry.isEmpty {
                            Text(localization.text("journal.placeholder"))
                                .foregroundStyle(
                                    Color.aanayaaraLavender.opacity(0.65)
                                )
                                .padding(.horizontal, 19)
                                .padding(.vertical, 23)
                                .allowsHitTesting(false)
                        }
                    }

                Button(action: {}) {
                    Label(
                        localization.text("journal.save"),
                        systemImage: "sparkles"
                    )
                    .font(.headline)
                    .foregroundStyle(Color.aanayaaraNight)
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .background(Color.aanayaaraGold, in: Capsule())
                }
                .buttonStyle(.plain)
            }
            .padding(20)
            .padding(.bottom, 110)
        }
        .scrollIndicators(.hidden)
        .background { CosmicBackground() }
        .navigationTitle(localization.text("journal.title"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct CosmicDetailScreen: View {
    @Environment(LocalizationStore.self) private var localization
    let imageName: String
    let eyebrow: String
    let title: String
    let text: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 28, style: .continuous)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 28, style: .continuous)
                            .stroke(Color.aanayaaraLavender.opacity(0.5))
                    }

                ScreenHeader(eyebrow: eyebrow, title: title, text: text)

                Button(action: {}) {
                    Label(
                        localization.text("action.readMore"),
                        systemImage: "arrow.right"
                    )
                    .font(.headline)
                    .foregroundStyle(Color.aanayaaraNight)
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .background(Color.aanayaaraGold, in: Capsule())
                }
                .buttonStyle(.plain)
            }
            .padding(20)
            .padding(.bottom, 110)
        }
        .scrollIndicators(.hidden)
        .background { CosmicBackground() }
    }
}

private struct ScreenHeader: View {
    let eyebrow: String
    let title: String
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(eyebrow)
                .font(.caption.weight(.semibold))
                .tracking(2)
                .foregroundStyle(Color.aanayaaraLavender)

            Text(title)
                .font(.system(.largeTitle, design: .serif, weight: .semibold))
                .foregroundStyle(Color.aanayaaraIvory)

            Text(text)
                .font(.body)
                .foregroundStyle(Color.aanayaaraLavender)
                .lineSpacing(5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct SettingsScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(LocalizationStore.self) private var localization

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text(localization.text("settings.language"))
                    .font(.system(.title2, design: .serif, weight: .semibold))
                    .foregroundStyle(Color.aanayaaraIvory)

                LanguageGlassCard()

                Text(localization.text("settings.languageHint"))
                    .font(.footnote)
                    .foregroundStyle(Color.aanayaaraLavender.opacity(0.82))
                    .lineSpacing(3)
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
        }
        .scrollIndicators(.hidden)
        .background { CosmicBackground() }
        .safeAreaInset(edge: .top, spacing: 0) {
            SettingsNavigationBar(
                title: localization.text("settings.title"),
                backLabel: localization.text("navigation.back"),
                action: { dismiss() }
            )
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

private struct SettingsNavigationBar: View {
    let title: String
    let backLabel: String
    let action: () -> Void

    var body: some View {
        HStack {
            Button(action: action) {
                Image(systemName: "chevron.left")
                    .font(.headline.weight(.bold))
                    .foregroundStyle(Color.aanayaaraIvory)
                    .frame(width: 44, height: 44)
                    .background(.ultraThinMaterial, in: Circle())
                    .background(
                        Color.aanayaaraIndigo.opacity(0.58),
                        in: Circle()
                    )
                    .overlay(
                        Circle().stroke(Color.aanayaaraLavender.opacity(0.32))
                    )
            }
            .buttonStyle(.plain)
            .accessibilityLabel(backLabel)

            Spacer()

            Color.clear
                .frame(width: 44, height: 44)
                .accessibilityHidden(true)
        }
        .overlay {
            Text(title)
                .font(.headline)
                .foregroundStyle(Color.aanayaaraIvory)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 6)
    }
}

private struct LanguageGlassCard: View {
    @Environment(LocalizationStore.self) private var localization

    var body: some View {
        VStack(spacing: 0) {
            LanguageOptionButton(
                title: AppLanguage.german.displayName,
                isSelected: localization.selectedLanguage == .german,
                action: { localization.selectedLanguage = .german }
            )

            Rectangle()
                .fill(Color.aanayaaraLavender.opacity(0.2))
                .frame(height: 1)
                .padding(.horizontal, 18)

            LanguageOptionButton(
                title: AppLanguage.english.displayName,
                isSelected: localization.selectedLanguage == .english,
                action: { localization.selectedLanguage = .english }
            )
        }
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 26, style: .continuous)
        )
        .background(
            Color.aanayaaraIndigo.opacity(0.55),
            in: RoundedRectangle(cornerRadius: 26, style: .continuous)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .stroke(Color.aanayaaraLavender.opacity(0.36), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.3), radius: 18, y: 9)
    }
}

private struct LanguageOptionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: "globe.europe.africa")
                    .font(.headline)
                    .frame(width: 34, height: 34)
                    .background(
                        Color.aanayaaraLavender.opacity(0.12),
                        in: Circle()
                    )

                Text(title)
                    .font(.headline)

                Spacer()

                Image(systemName: "checkmark.circle.fill")
                    .font(.title3)
                    .opacity(isSelected ? 1 : 0)
            }
            .foregroundStyle(
                isSelected ? Color.aanayaaraGold : Color.aanayaaraLavender
            )
            .padding(.horizontal, 18)
            .frame(minHeight: 64)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

extension Color {
    fileprivate static let aanayaaraNight = Color(
        red: 0.015,
        green: 0.025,
        blue: 0.12
    )
    fileprivate static let aanayaaraIndigo = Color(
        red: 0.08,
        green: 0.08,
        blue: 0.25
    )
    fileprivate static let aanayaaraLavender = Color(
        red: 0.69,
        green: 0.65,
        blue: 1.0
    )
    fileprivate static let aanayaaraIvory = Color(
        red: 1.0,
        green: 0.96,
        blue: 0.84
    )
    fileprivate static let aanayaaraGold = Color(
        red: 1.0,
        green: 0.76,
        blue: 0.34
    )
}

#Preview {
    ContentView()
}
