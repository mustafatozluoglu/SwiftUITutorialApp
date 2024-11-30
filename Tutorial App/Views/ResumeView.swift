import SwiftUI

struct ResumeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading) {
                    Text("John Doe")
                        .font(.largeTitle)
                        .bold()
                    Text("iOS Developer")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom)
                
                // Summary
                ResumeSection(title: "Summary") {
                    Text("Passionate iOS developer with experience in SwiftUI and UIKit. Committed to creating elegant, user-friendly applications while maintaining clean, efficient code.")
                }
                
                // Education
                ResumeSection(title: "Education") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bachelor of Computer Science")
                            .font(.headline)
                        Text("University Name")
                            .foregroundColor(.secondary)
                        Text("2019 - 2023")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                // Skills
                ResumeSection(title: "Skills") {
                    FlowLayout(spacing: 8) {
                        ForEach(["Swift", "SwiftUI", "UIKit", "Git", "iOS", "Xcode", "REST APIs", "Core Data"], id: \.self) { skill in
                            SkillBadge(skill: skill)
                        }
                    }
                }
                
                // Experience
                ResumeSection(title: "Experience") {
                    VStack(alignment: .leading, spacing: 15) {
                        ExperienceItem(
                            role: "iOS Developer",
                            company: "Tech Company",
                            period: "2023 - Present",
                            description: "• Developed and maintained iOS applications\n• Collaborated with cross-functional teams\n• Implemented new features and fixed bugs"
                        )
                        
                        ExperienceItem(
                            role: "iOS Developer Intern",
                            company: "Startup Inc",
                            period: "2022 - 2023",
                            description: "• Assisted in developing iOS applications\n• Learned industry best practices\n• Participated in code reviews"
                        )
                    }
                }
                
                // Projects
                ResumeSection(title: "Projects") {
                    VStack(alignment: .leading, spacing: 15) {
                        ProjectItem(
                            name: "Weather App",
                            description: "A SwiftUI weather application using OpenWeather API",
                            technologies: ["SwiftUI", "REST API", "CoreLocation"]
                        )
                        
                        ProjectItem(
                            name: "Task Manager",
                            description: "A productivity app with local storage and notifications",
                            technologies: ["SwiftUI", "CoreData", "UserNotifications"]
                        )
                    }
                }
                
                // Languages
                ResumeSection(title: "Languages") {
                    VStack(alignment: .leading, spacing: 8) {
                        LanguageItem(language: "English", level: "Native")
                        LanguageItem(language: "Spanish", level: "Intermediate")
                        LanguageItem(language: "French", level: "Basic")
                    }
                }
            }
            .padding()
        }
    }
}

// Supporting Views
struct ResumeSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .bold()
            content
            Divider()
        }
    }
}

struct SkillBadge: View {
    let skill: String
    
    var body: some View {
        Text(skill)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(15)
    }
}

struct ExperienceItem: View {
    let role: String
    let company: String
    let period: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(role)
                .font(.headline)
            Text(company)
                .foregroundColor(.secondary)
            Text(period)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(description)
                .padding(.top, 5)
        }
    }
}

struct ProjectItem: View {
    let name: String
    let description: String
    let technologies: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(name)
                .font(.headline)
            Text(description)
            FlowLayout(spacing: 8) {
                ForEach(technologies, id: \.self) { tech in
                    Text(tech)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
        }
    }
}

struct LanguageItem: View {
    let language: String
    let level: String
    
    var body: some View {
        HStack {
            Text(language)
                .font(.headline)
            Spacer()
            Text(level)
                .foregroundColor(.secondary)
        }
    }
}

// Helper view for flowing layout
struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let rows = arrangeSubviews(proposal: proposal, subviews: subviews)
        return CGSize(
            width: proposal.width ?? .zero,
            height: rows.last?.maxY ?? .zero
        )
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let rows = arrangeSubviews(proposal: proposal, subviews: subviews)
        
        for row in rows {
            for element in row.elements {
                element.view.place(
                    at: CGPoint(x: bounds.minX + element.x, y: bounds.minY + row.minY),
                    proposal: ProposedViewSize(width: element.width, height: element.height)
                )
            }
        }
    }
    
    private func arrangeSubviews(proposal: ProposedViewSize, subviews: Subviews) -> [Row] {
        var rows: [Row] = []
        var currentRow = Row(minY: 0)
        var x: CGFloat = 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(ProposedViewSize(width: nil, height: nil))
            
            if x + size.width > (proposal.width ?? .zero) {
                rows.append(currentRow)
                currentRow = Row(minY: currentRow.maxY + spacing)
                x = 0
            }
            
            currentRow.add(element: Element(view: subview, x: x, width: size.width, height: size.height))
            x += size.width + spacing
        }
        
        if !currentRow.elements.isEmpty {
            rows.append(currentRow)
        }
        
        return rows
    }
    
    struct Element {
        let view: LayoutSubview
        let x: CGFloat
        let width: CGFloat
        let height: CGFloat
    }
    
    struct Row {
        var elements: [Element] = []
        let minY: CGFloat
        
        var maxY: CGFloat {
            let maxHeight = elements.map(\.height).max() ?? 0
            return minY + maxHeight
        }
        
        mutating func add(element: Element) {
            elements.append(element)
        }
    }
}

#Preview {
    ResumeView()
} 