# 🤝 Contributing to Flutter Clean Starter

Thank you for considering contributing to this project! Your contributions are highly valued.

Whether you're fixing bugs, improving the documentation, submitting new features, or sharing ideas — you're welcome here. ❤️

---

## 📋 Guidelines

Please take a moment to review this guide before contributing.

### 🧱 Project Structure

This project follows Clean Architecture and Modular Architecture. Make sure your changes respect the existing separation of layers (`domain`, `data`, `features`) and module structure (`auth`, `posts`, etc.).

### 🧪 Testing

- Add tests for new features or bug fixes.
- Follow the existing pattern for `__tests__` inside each module.
- Use `mocktail` and `bloc_test` for testing where applicable.

### 📚 Documentation

- If you're adding a new feature, update or create relevant documentation in `/docs/`.
- Keep code comments clear and concise.

### 🚀 Commits

Follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/):

Examples:
```
feat(auth): add OTP support to login
fix(posts): correct date parsing issue in detail page
docs(readme): improve setup instructions
```

---

🗂️ Issues & Discussions
	•	If you found a bug, open an issue.
	•	For questions, use GitHub Discussions or start a thread in the issue comments.

---

📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thanks for helping make this project better! ✨

