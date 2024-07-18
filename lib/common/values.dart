import 'package:flutter/material.dart';

const Color darkPurple = Color(0xff432AA3);
const Color bgPurple = Color(0xfff3f0fa);
const Color iconPurple = Color(0xFF6f43c0);
const heightSpace = SizedBox(height: 50);
const widthSpace = SizedBox(width: 30);
const fontSizeBig = 30.0;
const fontSizeMiddle = 20.0;


const texts = {
  "main_1": "Home",
  "main_2": "Brand Story",
  "main_3": "App Preview",
  "main_4": "Premium",
  "main_5": "Blog",
  "main_6": "Contact",

  "home_1":
  "If you are looking to learn Korean 'easily' and 'quickly,'\nyou may feel free to hit the back button.",
  "home_2":
  "Learning a new language is never easy.\nDiscover how you can properly learn Korean in just 3 minutes.",
  "home_3": "I'm Jungwoo Park (Danny), a professional Korean language teacher.",
  "home_4": "More about Danny",
  "home_5": "What is the best way to learn Korean?",
  "home_6": "One-on-one lessons",
  "home_7": "Books",
  "home_8": "Instagram",
  "home_9": "Youtube",
  "home_10": "Apps",
  "home_11": "Each method has its own advantages and disadvantages.",
  "home_12": "Efficiency",
  "home_13": "Price",
  "home_14": "Lesson",
  "home_15": "Social media",
  "home_16": "For serious learners like you,\n'Lesson' is the most suitable option.",
  "home_17": "However, there are some conditions.",
  "home_18": "ㆍ You need to find a reliable and friendly teacher.",
  "home_19": "ㆍ The teacher must also be available at your desired time.",
  "home_20": "ㆍ You need to invest at least \$1,000 in tuition fees to see results. (\$20 x 50 hours)",
  "home_21": "Is there a way to learn effectively like lessons,\nbut at a lower cost, anytime and anywhere?",
  "home_22": "That's why I created this.",
  "home_23": "Podo Korean",
  "home_24": "the app for serious learners.",
  "home_25": "I created this app myself,\nbased on over 2,000 lessons of experience.",
  "home_26": "Preview Podo Korean",
  "home_27": "Why \'Podo Korean\' is Special",
  "home_28": "Creative and detailed explanations\nderived from over 2,000 lessons of experience",
  "home_29": "Audio recorded by a native Korean teacher,\nnot AI voices",
  "home_30": "Writing corrections and feedback\nfrom a native Korean teacher",
  "home_31": "Hear from users\nwho have experienced \'Podo Korean\' firsthand.",
  "home_32":
  "It's like taking a real Korean class with a private tutor! The lessons are very well explained and allow for rapid progress! Thank you for this app!",
  "home_33":
  "I love it! I have about 10 apps to learn Korean, but there's always something that bothers me. This one is perfect.",
  "home_34":
  "The app is really useful to learn if you are a beginner or to practice. The lessons are really well organised and the topics well explained. Also the cards made by the app developers are fun and they’ll make you smile I love using this app",
  "home_35":
  "I started learning hangul a few days ago and this app has literally helped me learn so much is such little time.",
  "home_36": "This app provides very detailed and clear explanations of grammar.",
  "home_37": "I LOVE YOU GUYS SO MUCH!!! To easy though but PERFECT I strongly recommend.",
  "home_38": "Simply perfect.",
  "home_39": "Very nice app and easy one I love it.",
  "home_40":
  "It is a very helpful app especially considering that I don't know any Korean so it's really helpful and I do recommend you using it beginner or not it's amazing. 감사합니다!",
  "home_41": "I think podo is one of the best app to consider if you want to learn Korean as a beginner",
  "home_42": "FAQ",
  "home_43": "How long will it take to become proficient in Korean?",
  "home_44":
  "Of course, it varies greatly depending on individual effort.\nAmong the 200+ students I have taught, two stand out the most. They knew no Korean at all initially but were very intelligent and consistent. They thoroughly reviewed what they learned in class and made sure to study vocabulary and practice sentence construction for at least five minutes every day, no matter how busy they were. After starting to learn Hangul with me, about a year later, they were able to discuss deep topics such as science, economics, and politics with me in Korean.\nTherefore, I would say that it takes 'at least one year' to become proficient in Korean.",
  "home_45": "Is learning a language through an app effective?",
  "home_46":
  "There are many ways to learn a language.\nHaving learned various languages (English, Japanese, Chinese, Thai) myself, I've tried numerous methods including private/group lessons, books, social media, language exchange, and apps. The reason I focus on apps is that, depending on the development approach, they can incorporate the strengths of other methods.\nBased on my experiences as a student learning multiple languages and as a teacher teaching Korean, I developed an app that truly enhances Korean language skills.\n\'Podo Korean\' is the most effective method for improving your Korean proficiency.",
  "home_47": "I am concerned about the quality of the lessons.",
  "home_48":
  "I have tried more than ten top-ranked Korean language apps in the market. Shockingly, I found awkward or incorrect expressions in most of these apps very easily. Unaware learners left positive feedback, leading to the spread of strange Korean.\nThis was the primary reason I decided to create a Korean language app.\n\'Podo Korean\' incorporates the exact methods I used when teaching Korean to students. With accurate and detailed lessons that you won't find in other Korean language apps, you will experience the same effectiveness as learning from a personal teacher.",
  "home_49": "Wouldn't it be difficult to consistently use the app?",
  "home_50":
  "The most important thing when learning a new language is \'Consistency\'.\nSince we always have our smartphones with us, learning a language through an app is the best way to maintain that consistency. Many serious learners prefer private lessons or books over apps because most Korean language apps have not provided lessons that satisfy serious learners.\nWith \'Podo Korean\', you can learn Korean lessons of the same quality as private lessons without the constraints of time and place. Even just 5 minutes a day is sufficient. Before you touch YouTube or social media apps, try launching \'Podo Korean\' first.",
  "home_51": "Is \'Podo Korean\' a free app?",
  "home_52":
  "For those whose goal is to read Hangul and engage in basic conversations, the approximately 100 free lessons available (with ads) will be sufficient.\nHowever, if you are a serious learner with higher goals, I strongly recommend the Premium subscription. It offers more lessons, deeper explanations, writing corrections, and level-appropriate reading practice.\nAdditionally, I consider Premium users as my students and take a personal interest in their progress. I will communicate with you and help you achieve your Korean language goals.",
  "home_53": "Still have more questions?",
  "home_54": "\'Podo Korean\' will help you achieve your goals.",
  "home_55": "Download Now",

  "brand_1": "I'm Jungwoo Park (Danny).",
  "brand_2": "I am a professional Korean teacher who has been teaching Korean since 2017.",
  "brand_3": "ㆍ I have taught over 2,000 lessons to more than 200 students, and I continue to do so.",
  "brand_4": "Watch the introduction video",
  "brand_5": "At the same time, I am also a language learner like you.",
  "brand_6": "I have tried various methods to learn languages.",
  "brand_7": "1:1 Lessons\n(Online and Offline)",
  "brand_8": "Books",
  "brand_9": "Youtube",
  "brand_10": "Apps",
  "brand_11": "Among these, I preferred learning through apps the most.",
  "brand_12": "Accessibility, Low cost, Customization...",
  "brand_13": "However...",
  "brand_14": "I tried using the Thai words I learned from the app with a Thai teacher.",
  "brand_15": "The teacher didn't understand...",
  "brand_16": "I tried using the English expressions I learned from the app with my American friend.",
  "brand_17": "My friend said it's not a commonly used expression...",
  "brand_18": "I could no longer trust and learn from the apps.",
  "brand_19": "And I became curious.",
  "brand_20": "What about Korean language apps?",
  "brand_21": "I tried the top 10 ranked Korean language apps in the app market.",
  "brand_22": "Within a few minutes, I easily found expressions like these.",
  "brand_23": "Incorrect",
  "brand_24": "Awkward",
  "brand_25": "Rarely used",
  "brand_26": "As a Korean teacher, I thought this was a serious problem.",
  "brand_27": "And I made a decision.",
  "brand_28": "I'll make it myself!",
  "brand_30": "ㆍ Development start.",
  "brand_31": "ㆍ Hangul app launch\n(terminated)",
  "brand_32": "ㆍ (old)Podo app launch\n(terminated)",
  "brand_33": "ㆍ Podo Words launch",
  "brand_34": "ㆍ Podo Korean launch",
  "brand_35": "Since then, I began learning a new language,\nprogramming.",
  "brand_36": "Learning a new language wasn't easy.\nHowever, I had these two things",
  "brand_37": "Clear goal",
  "brand_38": "Skilled mentor",
  "brand_39": "(A 'Skilled mentor' is my Korean student and programming teacher, Dave.\nSince 2018, we have been doing language exchange twice a week.)",
  "brand_40": "And finally, in October 2023,\nI was able to launch the Korean language app\n'Podo Korean.'",
  "brand_41": "\'Podo Korean\' will help you achieve your goals.",
  "brand_42": "Download Now",
};
