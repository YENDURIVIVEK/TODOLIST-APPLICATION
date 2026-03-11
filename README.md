# To-Do List Application (Flutter)

## Overview

This project is a **To-Do List mobile application developed using Flutter and Dart**.
The application helps users manage their daily tasks efficiently by allowing them to create, track, and complete tasks with deadlines and priorities. The app provides a clean and modern interface designed to improve productivity and task organization.

---

## Features

### 1. Splash Screen

* Displays an attractive startup screen when the app launches.
* Shows the application logo and title before navigating to the authentication screen.

### 2. User Authentication

* Users can **Sign Up** and **Login**.
* User credentials are stored locally using **JSON format**.
* Provides validation for email and password fields.

### 3. Dashboard (Home Screen)

* Displays all tasks in a structured list.
* Shows task details such as title, description, deadline, and priority.
* Includes task completion status.

### 4. Add Task

Users can create a new task with the following details:

* Task Title
* Task Description
* Priority Level (Low, Medium, High)
* Deadline with Date and Time

### 5. Priority-Based Color Coding

Each task is visually categorized using colors:

* **Green** → Low Priority
* **Orange** → Medium Priority
* **Red** → High Priority

### 6. Task Completion Tracking

* Tasks include a **checkbox** to mark them as completed.
* When a task is completed, the app records the **completion timestamp**.

### 7. Task Management

Users can:

* View tasks
* Add tasks
* Mark tasks as completed
* Delete tasks

### 8. Local Data Storage

* Tasks and authentication data are stored locally using **JSON and Shared Preferences**.
* Ensures tasks persist even after restarting the app.

---

## Technologies Used

* **Flutter** – UI framework for building cross-platform applications
* **Dart** – Programming language used by Flutter
* **SharedPreferences** – Local storage for saving user and task data
* **Material Design** – UI design components for a modern interface

---

## Project Structure

```
lib
│
├── main.dart
│
├── models
│   └── task.dart
│
├── screens
│   ├── splash_screen.dart
│   ├── auth_screen.dart
│   ├── dashboard_screen.dart
│   └── add_task_screen.dart
│
├── services
│   └── storage_service.dart
│
└── theme
    └── app_theme.dart
```

---

## Application Workflow

1. App Launch
2. Splash Screen
3. Login / Signup
4. Dashboard (View Tasks)
5. Add or Manage Tasks

---

## Purpose of the Project

The purpose of this project is to demonstrate the development of a **task management mobile application using Flutter**, focusing on:

* User interface design
* Local data storage
* Task organization
* Mobile application architecture

---

## Future Enhancements

Possible improvements for the application include:

* Cloud database integration (Firebase)
* Task reminders and notifications
* Task editing functionality
* Dark mode toggle
* Task filtering and search
* User profile management

---

## Conclusion

The **To-Do List Application** provides a simple and efficient way to manage daily activities. By combining an intuitive interface with essential task management features, the application enhances productivity and organization for users.
