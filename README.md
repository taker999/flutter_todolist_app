# ToDoList App

A comprehensive Flutter task management application with priority levels, reminders, notifications, and local data persistence using Hive database.

---

## 🎯 Features

- ✅ Create, edit, and delete tasks
- 📊 Priority levels (High, Medium, Low)
- 🔔 Smart notifications (reminder + due date alerts)
- 🔍 Real-time search by title/keywords
- 📅 Sort by priority, due date, or creation date
- 💾 Local data persistence with Hive
- 📱 Material Design 3 UI

---

## 🏗️ Architecture

**Pattern**: MVC (Model-View-Controller)  
**State Management**: GetX  
**Database**: Hive  
**Notifications**: Flutter Local Notifications
**Responsive**: ScreenUtil

## 🚀 Quick Start

### Prerequisites
- Flutter SDK 3.0.0+
- Dart SDK 3.0.0+

### Installation

```bash
# 1. Clone repository
git clone https://github.com/yourusername/todolist_app.git
cd todolist_app

# 2. Install dependencies
flutter pub get

# 3. Generate TypeAdapter (already included, but can regenerate)
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Run app
flutter run
```

### Build APK

```bash
flutter build apk --release
```

---

## 🛠️ Technologies

| Category | Technology                         |
|----------|------------------------------------|
| Framework | Flutter 3.0+                       |
| Language | Dart 3.0+                          |
| State Management | GetX 4.7.3                         |
| Database | Hive 2.2.3                         |
| Notifications | flutter_local_notifications 19.5.0 |
| UI | Material Design 3                  |

### Main Features
- **Home Screen**: Task list with search, sort, and statistics
- **Add/Edit Screen**: Form with priority selection and date picker
- **Notifications**: Reminder (1hr before) + Due date alerts

## 📋 Requirements Checklist

### Functional Features
- [x] Create, edit, delete tasks
- [x] Task attributes (title, description, priority, due date)
- [x] Priority levels (High, Medium, Low)
- [x] Reminders for tasks
- [x] Push notifications on expiration
- [x] Sort by priority/date/creation
- [x] Search by title/keyword
- [x] Data persistence

---

## 🎨 Design Highlights

### Color Scheme
- High Priority: Red (#F44336)
- Medium Priority: Orange (#FF9800)
- Low Priority: Green (#4CAF50)

### Status Indicators
- 🔴 Overdue: Red border + badge
- 🟠 Due Soon: Orange badge (within 24hrs)
- ✓ Completed: Strikethrough text

---