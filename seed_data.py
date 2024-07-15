# seed_data.py
from app import create_app, db
from app.models import User, Course, Lesson, Quiz

app = create_app()
app.app_context().push()

# Create sample data
user1 = User(email='user1@example.com', username='user1', password=generate_password_hash('password1', method='pbkdf2:sha256'), role='student') # type: ignore
user2 = User(email='user2@example.com', username='user2', password=generate_password_hash('password2', method='pbkdf2:sha256'), role='teacher') # type: ignore

course1 = Course(title='Introduction to Python', description='Learn the basics of Python programming.')
lesson1 = Lesson(title='Python Basics', content='Introduction to Python basics.', course=course1)
quiz1 = Quiz(title='Quiz 1', lesson=lesson1)

db.session.add(user1)
db.session.add(user2)
db.session.add(course1)
db.session.add(lesson1)
db.session.add(quiz1)

db.session.commit()
