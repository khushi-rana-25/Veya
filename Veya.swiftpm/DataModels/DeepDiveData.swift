import Foundation

struct SymptomDeepDiveEntry {
    let symptomName: String
    let companions: [String]
    let shortInsight: String
    let companionInsight: String
    let persistentInsight: String
}

enum DeepDiveData {
    static let all: [SymptomDeepDiveEntry] = [

        SymptomDeepDiveEntry(
            symptomName: "Nosebleeds",
            companions: ["Congestion", "Headaches", "Dry Mouth", "Dizziness", "Fatigue"],
            shortInsight: "A little nosebleed here and there is your body's way of saying 'I'm working overtime!' Extra blood volume is a good sign your baby is thriving. 🌸",
            companionInsight: "Congestion and nosebleeds often travel together during pregnancy — pregnancy rhinitis is real! Stay hydrated and use a humidifier to give those nasal passages some relief.",
            persistentInsight: "A few days of nosebleeds is common, but if they're happening very frequently or are heavy, it's worth a quick mention at your next appointment. You're doing so well managing this! 💪"
        ),

        SymptomDeepDiveEntry(
            symptomName: "Back Pain",
            companions: ["Pelvic Pain", "Hip Discomfort", "Leg Cramps", "Fatigue", "Difficulty Sleeping"],
            shortInsight: "Your centre of gravity is shifting every week to support your growing baby — your back is literally working harder than ever. A warm compress and a gentle walk can do wonders. 🌿",
            companionInsight: "Back pain alongside pelvic discomfort is very common in the 2nd and 3rd trimester. Consider a pelvic support belt and mention it to your midwife — physical therapy is often covered and hugely helpful.",
            persistentInsight: "More than a few days of back pain deserves attention. Make sure you're sleeping on your side with a pillow between your knees, and flag it to your care team if it's disrupting your sleep or daily life."
        ),

        SymptomDeepDiveEntry(
            symptomName: "Bleeding Gums",
            companions: ["Toothache", "Gum Sensitivity", "Swollen Gums", "Metallic Taste", "Nausea"],
            shortInsight: "Pregnancy gingivitis is incredibly common — up to 75% of pregnant women experience it! Your hormones are making your gums extra sensitive. Gentle brushing twice a day is your best friend. 🦷",
            companionInsight: "Sensitive gums plus a metallic taste or nausea often peak in the first trimester. Rinsing with a mild saltwater solution (1/2 tsp salt in warm water) can soothe irritation between brushes.",
            persistentInsight: "Persistent gum bleeding that isn't improving with good oral hygiene is worth a dentist visit — dental care during pregnancy is safe and recommended. Your oral health directly supports your baby's health too!"
        ),

        SymptomDeepDiveEntry(
            symptomName: "Constipation",
            companions: ["Bloating", "Stomach Pain", "Nausea", "Haemorrhoids", "Back Pressure"],
            shortInsight: "Progesterone is slowing your whole digestive system down — it's doing this to absorb more nutrients for your baby. Try adding a handful of prunes or flaxseed to your breakfast! 🍑",
            companionInsight: "Constipation and bloating together can make you feel very uncomfortable. Warm water with lemon first thing in the morning, along with gentle walks after meals, can get things moving again.",
            persistentInsight: "More than a week of constipation is worth discussing with your doctor — they can recommend a pregnancy-safe fibre supplement or stool softener. Don't push through this one alone!"
        ),

        SymptomDeepDiveEntry(
            symptomName: "Cramps",
            companions: ["Pelvic Pain", "Back Pain", "Spotting", "Dizziness", "Bloating"],
            shortInsight: "Mild cramping as your uterus grows is completely normal — it's called round ligament pain, and it means your body is doing exactly what it should. Rest and stay hydrated! 💧",
            companionInsight: "Cramping with pelvic pressure or back pain can feel overwhelming. Try changing positions slowly, applying gentle heat, and drinking a large glass of water — dehydration often intensifies cramps.",
            persistentInsight: "Cramps that stick around for several days, especially if they come in waves or are getting stronger, should be checked out promptly. You know your body best — trust your instincts and call your midwife."
        ),

        SymptomDeepDiveEntry(
            symptomName: "Dizziness",
            companions: ["Nausea", "Fatigue", "Blurred Vision", "Headaches", "Heart Palpitations"],
            shortInsight: "Your blood vessels are expanding rapidly to feed your growing baby, which can leave you feeling lightheaded. Rise slowly, eat little and often, and keep a snack nearby at all times! 🍌",
            companionInsight: "Dizziness paired with nausea is a classic first-trimester duo. Eat small snacks every 2-3 hours and make sure you're drinking at least 8 glasses of water a day. Lying on your left side can also help circulation.",
            persistentInsight: "Several days of dizziness — especially if you've fainted or have blurred vision — needs medical attention. Please contact your care team soon. You're not being dramatic; this is important to check!"
        ),

        SymptomDeepDiveEntry(
            symptomName: "Feeling Hot",
            companions: ["Sweating", "Dizziness", "Fatigue", "Swollen Ankles", "Difficulty Sleeping"],
            shortInsight: "You're literally running a tiny human furnace! Your metabolic rate increases significantly during pregnancy. Lightweight, breathable fabrics and a small desk fan can make a big difference. 🌬️",
            companionInsight: "Feeling hot alongside swelling is very common in the third trimester. Keep your feet elevated when possible, drink cold water throughout the day, and avoid being outside during peak heat hours.",
            persistentInsight: "If you're feeling hot AND have a temperature above 38°C (100.4°F), please contact your healthcare provider today — a fever during pregnancy needs prompt attention."
        ),

        SymptomDeepDiveEntry(
            symptomName: "Food Cravings and Aversions",
            companions: ["Nausea", "Fatigue", "Morning Sickness", "Heightened Smell", "Mood Changes"],
            shortInsight: "Cravings and aversions are your hormones communicating! Indulge in moderation and listen to your body — it often has a reason for what it's asking for. 🍋",
            companionInsight: "Cravings alongside nausea and heightened smell sensitivity are peak first-trimester experiences. Cold foods often smell less intense — try cold fruits, yogurt, or crackers if hot meals are triggering aversions.",
            persistentInsight: "If cravings have been intense for days and you're struggling to eat a balanced diet, a quick chat with your midwife about safe supplementation can really help. You're not alone — this is one of the most common pregnancy challenges!"
        ),

        SymptomDeepDiveEntry(
            symptomName: "Headaches",
            companions: ["Fatigue", "Neck Tension", "Light Sensitivity", "Dizziness", "Nausea"],
            shortInsight: "Hormonal surges, especially in the first trimester, are one of the leading causes of pregnancy headaches. Rest, hydration, and a cool, dark room are your best tools. 🌙",
            companionInsight: "Headaches with light sensitivity and fatigue can feel exhausting. A cold pack on your forehead and neck, combined with magnesium-rich foods (like bananas and spinach), may provide relief alongside rest.",
            persistentInsight: "Headaches lasting several days — especially if they're severe or come with blurred vision or hand swelling — need to be checked urgently. This can sometimes signal high blood pressure. Please reach out to your doctor today."
        ),

        SymptomDeepDiveEntry(
            symptomName: "Indigestion and Heartburn",
            companions: ["Bloating", "Nausea", "Stomach Pain", "Acid Taste", "Burping"],
            shortInsight: "Progesterone relaxes the valve between your stomach and oesophagus — so acid sneaks up more easily. Eating smaller meals and staying upright after eating makes a noticeable difference! 🥗",
            companionInsight: "Heartburn with bloating and nausea is very common, especially after week 20 when your baby starts pressing upward. Avoid lying down within 2 hours of eating, and try sipping cold milk for quick relief.",
            persistentInsight: "Heartburn that's been going on for several days and is affecting your sleep or eating deserves attention. Your doctor or midwife can recommend a pregnancy-safe antacid — you don't need to just endure this!"
        ),

        SymptomDeepDiveEntry(
            symptomName: "Leaking from Nipples",
            companions: ["Breast Tenderness", "Breast Swelling", "Nipple Sensitivity", "Bra Discomfort"],
            shortInsight: "Leaking colostrum is your body pre-loading with liquid gold for your baby — it's a beautiful sign your body is already getting ready! Nursing pads inside your bra will keep you comfortable. 🌼",
            companionInsight: "Leaking alongside breast tenderness is perfectly normal. A soft, wireless bra and nursing pads will help manage discomfort. Some women start leaking as early as 14 weeks — every body is different!",
            persistentInsight: "Colostrum leaking for several days is normal and actually wonderful — it shows your body is well-prepared. However, if the discharge appears pink or bloody, please do mention it to your midwife at your next visit."
        ),

        SymptomDeepDiveEntry(
            symptomName: "Peeing a Lot",
            companions: ["Pelvic Pressure", "Incontinence", "Disrupted Sleep", "Urgency", "Back Pressure"],
            shortInsight: "Your kidneys are filtering 50% more blood than usual — which means more bathroom trips! This is a sign of incredible efficiency, not a problem. Just don't cut back on fluids during the day. 💧",
            companionInsight: "Frequency paired with pelvic pressure is very normal as your baby's head moves lower. Leaning forward slightly when urinating helps fully empty your bladder and can reduce the 'need to go again' feeling right after.",
            persistentInsight: "If frequent urination comes with any burning, pain, or you're passing very small amounts each time, it could be a UTI — which needs treatment during pregnancy. Please contact your care provider to rule this out!"
        ),

        SymptomDeepDiveEntry(
            symptomName: "Pelvic Pain",
            companions: ["Back Pain", "Hip Discomfort", "Leg Weakness", "Groin Pain", "Difficulty Walking"],
            shortInsight: "Relaxin, your pregnancy hormone, is softening your pelvic ligaments to prepare for birth — which is amazing, even if it aches! A pelvic support belt can provide significant relief throughout the day. 🎀",
            companionInsight: "Pelvic pain with hip or groin discomfort is classic Pelvic Girdle Pain (PGP). Keeping your knees together when getting in and out of the car or bed, and avoiding asymmetric movements, can reduce flare-ups significantly.",
            persistentInsight: "Pelvic pain that's been present for several days and is limiting your mobility really deserves a referral to a pelvic physiotherapist. Please ask your midwife — this is a recognised pregnancy condition and you deserve proper support!"
        ),

        SymptomDeepDiveEntry(
            symptomName: "Piles (Hemorrhoids)",
            companions: ["Constipation", "Rectal Itching", "Rectal Discomfort", "Bloating", "Pelvic Pressure"],
            shortInsight: "Piles during pregnancy are caused by increased pelvic pressure and are extremely common — you're in very good company! Witch hazel pads and a good fibre intake make a real difference. 🌿",
            companionInsight: "Piles alongside constipation create a challenging cycle. Breaking the constipation cycle is the key — try stool softeners safe in pregnancy (ask your pharmacist) and increase your fluid and fibre intake together.",
            persistentInsight: "Several days of pain or itching from piles is worth flagging to your GP or midwife — they can recommend specific pregnancy-safe creams that provide much faster relief than waiting it out. You deserve to feel comfortable!"
        ),

        SymptomDeepDiveEntry(
            symptomName: "Stomach Pain",
            companions: ["Bloating", "Cramps", "Constipation", "Nausea", "Back Pressure"],
            shortInsight: "Mild stomach pain from gas, round ligament stretching, or constipation is very common. Moving slowly after sitting, and avoiding trigger foods, usually brings quick relief. 🌱",
            companionInsight: "Stomach pain with bloating and cramps together can feel intense, but are usually harmless. Peppermint tea (cold — not hot in pregnancy) and gentle walking can ease gas pain significantly.",
            persistentInsight: "Stomach pain lasting several days — especially if it's worsening, comes in waves, or is accompanied by fever — needs medical review today. Please don't wait it out; call your midwife or healthcare provider now."
        ),

        SymptomDeepDiveEntry(
            symptomName: "Swollen Ankles, Feet, and Fingers",
            companions: ["Pelvic Pressure", "Back Pain", "Fatigue", "Varicose Veins", "Heat Sensitivity"],
            shortInsight: "Your body is holding onto extra fluid to support your placenta and baby — it's all part of the plan! Elevating your feet whenever you sit and sleeping on your left side helps reduce swelling overnight. 💆‍♀️",
            companionInsight: "Swelling alongside fatigue and back pressure is a very common third-trimester trio. Compression socks (put them on before getting out of bed in the morning!) and regular short walks to keep circulation moving are your best tools.",
            persistentInsight: "Sudden or severe swelling — especially in your face or hands — needs urgent medical attention as it can be a sign of preeclampsia. Please contact your care team immediately if swelling is new, sudden, or feels different."
        ),

        SymptomDeepDiveEntry(
            symptomName: "Tender, Swollen Breasts",
            companions: ["Nipple Sensitivity", "Fatigue", "Mood Changes", "Heightened Smell", "Nausea"],
            shortInsight: "Tender breasts are often one of the very first signs your body sends — your hormones are surging to support implantation and growth. A well-fitting, soft bra (even to sleep in) can make a huge difference! 💗",
            companionInsight: "Breast tenderness with fatigue and mood shifts is classic early pregnancy. Your oestrogen and progesterone are climbing rapidly — be gentle with yourself and know this usually eases after the first trimester.",
            persistentInsight: "Prolonged breast tenderness is normal, but do keep an eye out for any new lumps, unusual discharge, or redness — these are always worth mentioning to your midwife, even during pregnancy."
        ),

        SymptomDeepDiveEntry(
            symptomName: "Tiredness and Sleep Problems",
            companions: ["Headaches", "Dizziness", "Mood Swings", "Difficulty Concentrating", "Restless Legs"],
            shortInsight: "In the first trimester, your body is building a whole organ (the placenta) from scratch — of course you're exhausted! This is one of the most valid reasons to rest you'll ever have. Sleep when you can. 🌙",
            companionInsight: "Tiredness paired with restless legs or mood swings is a very common pregnancy combination. Iron-rich foods and gentle stretching before bed can help with both restlessness and energy levels.",
            persistentInsight: "Fatigue that's been overwhelming for several days — especially if it comes with breathlessness or heart palpitations — could signal anaemia, which is very treatable. Ask your midwife to check your iron levels at your next visit."
        ),

        SymptomDeepDiveEntry(
            symptomName: "Thrush (Yeast Infection)",
            companions: ["Vaginal Itching", "Burning Sensation", "Unusual Discharge", "Vulval Irritation"],
            shortInsight: "Pregnancy hormones alter your vaginal pH, making yeast overgrowth more likely — it's not a hygiene issue at all. Loose cotton underwear and avoiding scented products will help prevent recurrence. 🌸",
            companionInsight: "Itching and discharge changes alongside thrush symptoms are expected. Please don't self-treat with over-the-counter products without checking with your pharmacist first — some treatments aren't safe during pregnancy.",
            persistentInsight: "Recurring or persistent thrush symptoms really need a proper diagnosis from your GP or midwife, as they can confirm it's thrush and not another type of infection, and prescribe the correct pregnancy-safe treatment."
        ),

        SymptomDeepDiveEntry(
            symptomName: "Incontinence",
            companions: ["Pelvic Pain", "Urgency", "Peeing a Lot", "Pelvic Pressure", "Difficulty Exercising"],
            shortInsight: "Stress incontinence affects up to 40% of pregnant women — sneezing and laughing with confidence is something Kegel exercises are specifically designed to help with! Try squeezing your pelvic floor muscles 10 times, 3 times a day. 💪",
            companionInsight: "Leaking alongside urgency and pelvic pressure means your pelvic floor is working really hard. A pelvic physiotherapist can teach you targeted exercises that make a significant, lasting difference — ask your midwife for a referral!",
            persistentInsight: "Incontinence that's been happening for several days and is affecting your confidence or daily life is worth discussing at your next appointment. A pelvic health physio referral during pregnancy is incredibly effective and commonly available."
        ),

        SymptomDeepDiveEntry(
            symptomName: "Vaginal Bleeding",
            companions: ["Cramping", "Pelvic Pain", "Back Pain", "Dizziness", "Feeling Faint"],
            shortInsight: "Any vaginal bleeding during pregnancy needs to be checked — please contact your midwife or maternity unit today, even if it's light or seems to have stopped. This is always the right thing to do. 💛",
            companionInsight: "Bleeding with cramping or pelvic pain needs prompt attention — please do not wait. Contact your maternity unit or go to your nearest A&E right now. You are doing the right thing by paying attention to your body.",
            persistentInsight: "Vaginal bleeding for several days is always a reason to be seen urgently. Please contact your healthcare provider immediately — do not wait for a scheduled appointment. Your and your baby's safety comes first."
        ),

        SymptomDeepDiveEntry(
            symptomName: "Vaginal Discharge",
            companions: ["Mild Odour", "Itching", "Dampness", "Pelvic Discomfort"],
            shortInsight: "An increase in milky-white, mild-smelling discharge (leukorrhea) is completely normal throughout pregnancy — it's your body protecting your vaginal environment. A panty liner will keep you comfortable. 🤍",
            companionInsight: "Discharge with mild discomfort is usually normal. However, if you notice a change in colour (yellow, green, grey), a strong or fishy smell, or itching/burning, this is worth a call to your midwife to rule out infection.",
            persistentInsight: "Discharge that's changed in colour, smell, or texture over several days should be checked by your midwife — it's quick, non-invasive, and will give you peace of mind. Don't hesitate to reach out!"
        ),

        SymptomDeepDiveEntry(
            symptomName: "Varicose Veins",
            companions: ["Leg Aches", "Swollen Ankles", "Heavy Legs", "Itchy Skin", "Leg Cramps"],
            shortInsight: "Varicose veins are caused by the pressure your growing uterus puts on your circulation — they're very common and usually improve after birth. Compression stockings are genuinely transformative for daily comfort! 🧦",
            companionInsight: "Varicose veins with heavy, achy legs and swelling is a classic trio. Putting on compression socks before getting out of bed in the morning (before blood pools) and elevating your legs in the evening will give the most relief.",
            persistentInsight: "If your varicose veins are becoming red, warm, hard, or very painful, please contact your GP — this can occasionally signal a clot and needs prompt assessment. Otherwise, mention comfort at your next antenatal appointment."
        ),

        SymptomDeepDiveEntry(
            symptomName: "Vomiting and Morning Sickness",
            companions: ["Food Aversions", "Fatigue", "Dizziness", "Heightened Smell", "Dehydration"],
            shortInsight: "Morning sickness (which can strike any time of day!) typically peaks at 9 weeks and improves by 14-16 weeks for most people. Small, bland snacks before getting out of bed, and ginger in any form, are widely loved for a reason! 🫚",
            companionInsight: "Vomiting with food aversions and heightened smell sensitivity means even cooking smells might be impossible right now. Cold foods, plain crackers, frozen fruit, and letting someone else cook can all protect your sensitive stomach.",
            persistentInsight: "If you've been vomiting for several days and are struggling to keep fluids down, you may need IV fluids. This is a recognised condition called hyperemesis gravidarum — please contact your GP or maternity unit today. You shouldn't have to cope with this alone."
        ),

        SymptomDeepDiveEntry(
            symptomName: "Skin Changes",
            companions: ["Itching", "Stretch Mark Tenderness", "Dryness", "Sensitivity to Sun", "Acne"],
            shortInsight: "Pregnancy hormones drive a whole range of skin changes — from the 'pregnancy glow' to stretch marks and pigmentation. Most fade significantly after birth. Moisturising twice daily and high SPF will be your skin's best friends! ✨",
            companionInsight: "Skin changes with itching and dryness respond well to fragrance-free, gentle moisturisers applied right after showering (while skin is still slightly damp). Coconut oil, shea butter, and dedicated stretch mark creams all have their fans.",
            persistentInsight: "Intense itching — especially on your palms and the soles of your feet — can occasionally be a sign of a liver condition called cholestasis of pregnancy. Please contact your midwife today if the itching is severe or keeps you awake at night."
        ),
    ]

    /// Returns the deep dive entry for a given symptom name, or a sensible default.
    static func entry(for symptomName: String) -> SymptomDeepDiveEntry {
        all.first { $0.symptomName == symptomName } ?? SymptomDeepDiveEntry(
            symptomName: symptomName,
            companions: ["Fatigue", "Dizziness", "Nausea", "Back Discomfort", "Trouble Sleeping"],
            shortInsight: "You're doing an incredible job tracking how you feel. Logging your symptoms helps you and your care team spot patterns early. Keep it up, mama! 🌸",
            companionInsight: "Noticing multiple symptoms at once is very common during pregnancy. Stay hydrated, rest when you can, and don't hesitate to mention any combination of symptoms to your midwife.",
            persistentInsight: "Symptoms that have been lingering for several days are always worth mentioning at your next appointment — your care team would much rather hear about it early. You're doing the right thing by paying attention."
        )
    }
}
