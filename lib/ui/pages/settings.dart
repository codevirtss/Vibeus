import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibeus/bloc/authentication/authentication_bloc.dart';
import 'package:vibeus/bloc/authentication/authentication_event.dart';
import 'package:vibeus/ui/constants.dart';
import 'package:vibeus/ui/pages/aboutsett.dart';

class Settings extends StatefulWidget {



  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            "Settings",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  "About",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => About()));
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                title: Text(
                  "Privacy Policy",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                title: Text(
                  "Terms & Condition",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => TermsandConditon()));
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                title: Text(
                  "Safety tips",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Safetytips()));
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                title: Text(
                  "Community guidelines",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ComunityGuidlines()));
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Colors.grey,
                ),
              ),
              ListTile(
                title: Text(
                  "Sign out",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
             
                onTap: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                  Navigator.pop(context);
                },
              ),
           
            ],
          ),
        ));
  }
}

class Safetytips extends StatefulWidget {
  @override
  _SafetytipsState createState() => _SafetytipsState();
}

class _SafetytipsState extends State<Safetytips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          "Saftey Tips",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Linkify(
              onOpen: (link) async {
                await launch(link.url);
                print(link);
              },
              text: """
Meeting new people is exciting, but you should always be cautious when interacting with someone you don’t know. Use your best judgment and put your safety first, whether you are exchanging initial messages or meeting in person. While you can’t control the actions of others, there are things you can do to help you stay safe during your Vibeus experience.
Online Safety
•	Never Send Money or Share Financial Information

Never send money, especially over wire transfer, even if the person claims to be in an emergency. Wiring money is like sending cash — it’s nearly impossible to reverse the transaction or trace where the money went. Never share information that could be used to access your financial accounts. If another user asks you for money, report it to us immediately.
For tips on avoiding romance scams, check out some advice from the U.S Federal Trade Commission  https://www.consumer.ftc.gov/articles/what-you-need-know-about-romance-scams or in the video. https://www.youtube.com/watch?v=jlxWxH0mgU8&feature=emb_logo 
•	Protect Your Personal Information

Never share personal information, such as your social security number, home or work address, or details about your daily routine (e.g., that you go to a certain gym every Monday) with people you don’t know. If you are a parent, limit the information that you share about your children on your profile and in early communications. Avoid sharing details such as your children’s names, where they go to school, or their ages or genders.
•	Stay on the Platform

Keep your conversations on the Vibeus platform while you get to know your match. Because exchanges on Vibeus are subject to our Safe Message Filters, users with bad intentions often try to move the conversation to text, messaging apps, email, or phone right away.
•	Be Wary of Long Distance and Overseas Relationships

Watch out for scammers who claim to be from your country but stuck somewhere else, especially if they ask for financial help to return home. Be wary of anyone who will not meet in person or talk on a phone/video call—they may not be who they say they are. If someone is avoiding your questions or pushing for a serious relationship without meeting or getting to know you first — that’s a red flag.
•	Report All Suspicious and Offensive Behaviour

You know when someone’s crossed the line and when they do, we want to know about it. Block and report anyone that violates our terms. Here are some examples of violations:
o	Requests for money or donations
o	Underage users
o	Harassment, threats, and offensive messages
o	Inappropriate or harmful behaviour during or after meeting in person
o	Fraudulent profiles
o	Spam or solicitation including links to commercial websites or attempts to sell products or services
You can report any concerns about suspicious behaviour from any profile page or messaging window or to teamvibeus@gmail.com. 
 
•	Protect Your Account

Be sure to pick a strong password, and always be careful when logging into your account from a public or shared computer. Vibeus will never send you an email asking for your username and password information — if you receive an email asking for account information, report it immediately.
Meeting in Person
•	Don’t Be in A Rush

Take your time and get to know the other person before agreeing to meet or chat off Vibeus. Don’t be afraid to ask questions to screen for any red flags or personal dealbreakers. A phone or video call can be a useful screening tool before meeting.
•	Meet in Public and Stay in Public

Meet for the first few times in a populated, public place — never at your home, your date’s home, or any other private location. If your date pressures you to go to a private location, end the date.
•	Tell Friends and Family About Your Plans

Tell a friend or family member of your plans, including when and where you’re going. Have your cell phone charged and with you at all times.
•	Be in Control of Your Transportation

We want you to be in control of how you get to and from your date so that you can leave whenever you want. If you’re driving yourself, it’s a good idea to have a backup plan such as a ride-share app or a friend to pick you up.
•	Know Your Limits

Be aware of the effects of drugs or alcohol on you specifically — they can impair your judgment and your alertness. If your date tries to pressure you to use drugs or drink more than you’re comfortable with, hold your ground and end the date.
•	Don’t Leave Drinks or Personal Items Unattended

Know where your drink comes from and know where it is at all times — only accept drinks poured or served directly from the bartender or server. Many substances that are slipped into drinks to facilitate sexual assault are odourless, colourless, and tasteless. Also, keep your phone, purse, wallet, and anything containing personal information on you at all times.
•	If You Feel Uncomfortable, Leave

It’s okay to end the date early if you’re feeling uncomfortable. In fact, it’s encouraged. And if your instincts are telling you something is off or you feel unsafe, ask the bartender or server for help.
•	LGBTQ+ Travel

Be careful while traveling. We recognize and believe in the importance of being inclusive of all gender identities and sexual orientations, but the reality is this: nowhere in the world is without potential risk, and some countries have specific laws that target LGBTQ+ people. Check out the laws around you when you travel to a new place and research what types of legal protection, if any, are available to you based on sexual orientation. In the event that you’re in unsafe territory, we suggest disabling your Vibeus account or going Incognito. It’s important to exercise extra caution if you choose to connect with new people in these countries - as some law enforcement have been known to use dating apps as tools for potential entrapment. Some countries have also recently introduced laws that criminalize communications between individuals on same-sex dating applications or websites and even aggravate penalties if that communication leads to sexual encounters.

Visit https://ilga.org/maps-sexual-orientation-laws to see the latest sexual orientation laws by country, and consider donating to support their research. Source: ILGA World, Updated March 2019
Sexual Health & Consent
•	Protect Yourself

When used correctly and consistently, condoms can significantly reduce the risk of contracting and passing on STI’s like HIV. But, be aware of STIs like herpes or HPV that can be passed on through skin-to-skin contact. The risk of contracting some STIs can be reduced through https://www.ashasexualhealth.org/vaccines/ .
•	Know Your Status

Not all STIs show symptoms, and you don’t want to be in the dark about your status. Stay on top of your health and prevent the spread of STIs by getting tested regularly.
•	Talk About It

Communication is everything: Before you get physically intimate with a partner, talk about sexual health and STI testing. And be aware — in some places, it’s actually a crime to knowingly pass on an STI. Need help starting the conversation? Here are some tips https://www.plannedparenthood.org/learn/stds-hiv-safer-sex/get-tested/how-do-i-talk-my-partner-about-std-testing  
•	Consent

All sexual activity must start with consent and should include ongoing check-ins with your partner. Verbal communication can help you and your partner ensure that you respect each other’s boundaries. Consent can be withdrawn at any time, and sex is never owed to anyone. Do not proceed if your partner seems uncomfortable or unsure, or if your partner is unable to consent due to the effects of drugs or alcohol. 
Resources for Help, Support, or Advice
Remember — even if you follow these tips, no method of risk reduction is perfect. If you have a negative experience, please know that it is not your fault and help is available. Report any incidents to our helping email teamvibeus@gmail.com and consider reaching out to one of the resources below. If you feel you are in immediate danger or need emergency assistance, call 911 (U.S. or Canada) or your local law enforcement agency.
RAINN’s National Sexual Assault Hotline
1-800-656-HOPE (4673) | online.rainn.org | www.rainn.org
Planned Parenthood
1-800-230-7526 | www.plannedparenthood.org
National Domestic Violence Hotline
1-800-799-SAFE (7233) or 1-800-787-3224 | www.thehotline.org
National Human Trafficking Hotline
1-888-373-7888 or text 233733 | www.humantraffickinghotline.org
National Sexual Violence Resource Center
1-877-739-3895 | www.nsvrc.org
National Center for Missing & Exploited Children
1-800-THE-LOST (843-5678) | www.cybertipline.com
Cyber Civil Rights Initiative
1-844-878-2274 | www.cybercivilrights.org
VictimConnect - Crime Victim Resource Center
1-855-4VICTIM (855-484-2846) | www.victimconnect.org
FBI Internet Crime Complaint Center
www.ic3.gov
LGBT National Help Center
1-888-843-4564 | www.glbtnationalhelpcenter.org
Trans Lifeline
1-877-565-8860 (US) or 1-877-330-6366 (CA) | www.translifeline.org
If you are outside the US:
•	https://mtch.com/safety-details-international for additional resources in many of the countries where we operate. 
•	https://ilga.org/about-us for information regarding international sexual orientation laws from the International Lesbian, Gay, Bisexual, Trans and Intersex Association (ILGA).
""",
              style: TextStyle(
                color: Colors.black,
              ),
              linkStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          "Privacy Policy",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Linkify(
              onOpen: (link) async {
                await launch(link.url);
                print(link);
              },
              text: """
Privacy Policy
Updated at 10-1-2021
Vibeus. ("we," "our," or "us") is committed to protecting your privacy. This Privacy Policy explains how your personal information is collected, used, and disclosed by Vibeus. 
This Privacy Policy applies to application, Vibeus. By accessing or using our Service, you signify that you have read, understood, and agree to our collection, storage, use, and disclosure of your personal information as described in this Privacy Policy and our Terms of Service.
Definitions and key terms 
For this Privacy Policy:
• Cookie: small amount of data generated by a website and saved by your web browser. It is used to identify your browser, provide analytics, remember information about you such as your language preference or login information.
• Company: when this policy mentions "Company." "we," "us," or "our," it refers to Vibeus that is responsible for your information under this Privacy Policy. 
• Country: where Vibeus or the owners/founders of Vibeus are based, in this case is India. 
• Customer: refers to the company, organization or person that signs up to use the Vibeus Service to manage the relationships with your consumers or service users. 
• Device: any internet connected device such as a phone, tablet, computer or any other device that can be used to visit Vibeus and use the services. 
• IP address: Every device connected to the Internet is assigned a number known as an internet protocol (IP) address. These numbers are usually assigned in geographic blocks. An IP address can often be used to identify the location from which a device is connecting to the internet 
 • Personnel: refers to those individuals who are employed by Vibeus or are under contract to perform a service on behalf of one of the parties. 
• Personal Data: any information that directly, indirectly, or in connection with other information - including a personal identification number - allows for the identification or identifiability of a natural person. 
• Service: refers to the service provided by Vibeus as described in the relative terms (if available) and on this platform. 
•Third-party service: refers to advertisers, contest sponsors, promotional and marketing partners, and others who provide our content or whose products or services we think may interest you. 
• You: a person or entity that is registered with Vibeus to use the Services.

What Information Do We Collect? 
We collect information from you when you visit our service, register, place an order, subscribe to our newsletter, respond to a survey or fill out a form.
• Name / Username 
• Phone Numbers
• Email Addresses 
•Mailing Addresses. 
•Job Titles 
•Age 
•Password 
We also collect information from mobile devices for a better user experience, although these features are completely optional:

How Do We Use the Information We Collect? 
Any of the information we collect from you may be used in one of the following ways: 
• To personalize your experience (your information helps us to better respond to your individual needs) 
•To improve our service (we continually strive to improve our service offerings based on the information and feedback we receive from you) 
• To improve customer service (your information helps us to more effectively respond to your customer service requests and support needs) To process trans ns 
• To administer a contest, promotion, survey or other site feature 
• To send periodic emails

When do we use customer information from third parties?
We receive some information from the third parties when you contact us or example, when you submit your email address to us to show interest in becoming our customer, we receive information from a third party that provides automated fraud detection services to us. We also occasionally collect information that is made publicly available on social media websites. You can control how much of your information social media websites make public by visiting these websites and changing your privacy settings. 


Do we share the information we collect with third parties? 
We may share the information that we collect, both personal and non-personal, with third parties such as advertisers, contest sponsors, promotional and marketing partners, and others who provide our content or whose products or services we think may interest you. We may also share it with our current and future affiliated companies and business partners, and if we are involved in a merger, asset sale or other business reorganization, we may also share or transfer your personal and non-personal information to our successors-in-interest
We may engage trusted third-party service providers to perform functions and provide services to us, such as hosting and maintaining our servers and our service, database storage and management, e-mail management, storage marketing, credit card processing, customer service and fulfilling orders for products and services you may purchase through our platform. We will likely share your personal information, and possibly some non-personal information, with these third parties to enable them to perform these services for us and for you.
We may share portions of our log file data, including IP addresses, for analytics purposes with third parties such as web analytics partners, application developers, and ad networks. If your IP address is shared, it may be used to estimate general location and other technographics such as connection speed, whether you have visited the service in a shared location, and type of device used to visit the service. They may aggregate information about our advertising and what you see on the service and then provide auditing, research and reporting for us and our advertisers.
We may also disclose personal and non-personal information about you to government or law enforcement officials or private parties as we, in our sole discretion, believe necessary or appropriate in order to respond to claims, legal process (including subpoenas). to protect our rights and interests or those of a third party, the safety of the public or any person, to prevent or stop any illegal, unethical, or legally actionable activity, or to otherwise comply with applicable court orders, laws, rules and regulations.

Where and when is information collected from customers and end users?
We will collect personal information that you submit to us. We may also receive personal information about you from third parties as described above. 

How Do We Use Your Email Address? 
By submitting your email address on this both, you agree to receive emails from us. You can cancel your participation in any of these email lists at any time by clicking on the opt-out link or other unsubscribe option that is included in the respective email. We only send emails to people who have authorized us to contact them, either directly, or through a third party. We do not send unsolicited commercial emails, because we hate spam as much as you do. By submitting your email address, you also agree to allow us to use your email address for customer audience targeting on sites like Facebook, where we display custom advertising to specific people who have opted-in to receive communications from us. Email addresses submitted only through the order processing page will be used for the sole purpose of sending you information and updates pertaining to your order. If, however, you have provided the same email to us through another method, we may use it for any of the purposes stated in this Policy. Note: If at any time you would to unsubscribe from receiving future emails, we include detailed unsubscribe instructions at the bottom of each email.

Could my information be transferred to other countries?
We are incorporated in India. Information collected via our website, through direct interactions with you, or from use of our help services may be transferred from time to time to our offices or personnel, or to third parties, located throughout the world, and may be viewed and hosted anywhere in the world, including countries that may not have laws of general applicability regulating the use and transfer of such data. To the fullest extent allowed by applicable law, by using any of the above, you voluntarily consent to the trans- border transfer and hosting of such information.

Is the information collected through our service secure?
 We take precautions to protect the security of your information. We have physical, electronic, and managerial procedures to help safeguard, prevent unauthorized access, maintain data security, and correctly use your information. However, neither people nor security systems are fool proof, including encryption systems In addition, people can commit intentional crimes, make mistakes or fail to follow policies, Therefore, while we use reasonable efforts to protect your personal information, we cannot guarantee its absolute security. If applicable law imposes any non-disclaimable duty to protect your personal information, you agree that intentional misconduct will be the standards used to measure our compliance with that duty.

 Can I update or correct my information?
The rights you have to request updates or corrections to the information we collect depend on your relationship with us. Personnel may update or correct their information as detailed in our internal company employment policies. Customers have the right to request the restriction of certain uses and disclosures of personally identifiable information as follows. You can contact us in order to (1) update or correct your personally identifiable information, (2) change your preferences with respect to communications and other information you receive from us, or (3) delete the personally identifiable information maintained about you on our systems (subject to the following paragraph), by cancelling your account. Such updates, corrections, changes and deletions will have no effect on other information that we maintain, or information that we have provided to third parties in accordance with this Privacy Policy prior to such update, correction, change or deletion. To protect your privacy and security, we may take reasonable steps (such as requesting a unique password) to verify your identity before granting you profile access or making corrections. You are responsible for maintaining the secrecy of your unique password and account information at all times. You should be aware that it is not technologically possible to remove each and every record of the information you have provided to us from our system. The need to back up our systems to protect information from inadvertent loss means that a copy of your information may exist in a non-erasable form that will be difficult or impossible for us to locate. Promptly after receiving your request, all personal information stored in databases we actively use. and other readily searchable media will be updated, corrected, changed or deleted, as appropriate, as soon as and to the extent reasonably and technically practicable. If you are an end user and wish to update, delete, or receive any information we have about you, you may do so by contacting the organization of which you are a customer.

Sale of Business 
We reserve the right to transfer information to a third party in the event of a sale, merger or other transfer of all or substantially all of the assets of us or any of its Corporate Affiliates (as defined herein), or that portion of us or any of its Corporate Affiliates to which the Service relates, or in the event that we discontinue our business or file a petition or have filed against us a petition in bankruptcy. reorganization or similar proceeding, provided that the third party agrees to adhere to the terms of this Privacy Policy.

Affiliates 
We may disclose information (including personal information) about you to our Corporate Affiliates. For purposes of this Privacy Policy, "Corporate Affiliate" means any person or entity which directly or indirectly controls, is controlled by or is under common control with us, whether by ownership or otherwise. Any information relating to you that we provide to our Corporate Affiliates will be treated by those Corporate Affiliates in accordance with the terms of this Privacy Policy. 

How Long Do We Keep Your Information?
 We keep your information only so long as we need it to provide service to you and fulfil the purposes described in this policy. This is also the case for anyone that we share your information with and who carries alit services on our behalf. When we no longer need to use your information and there is no need for us to keep it to comply with our legal or regulatory obligations, we'll either remove it from our systems or depersonalize it so that we can't identify you. 

How Do We Protect Your Information?
We implement a variety of security measures to maintain the safety of your personal information when you place an order or enter, submit, or access your personal information. We offer the use of a secure server. All supplied sensitive/credit information is transmitted via Secure Socket Layer (SSL) technology and then encrypted into our Payment gateway providers database only to be accessible by those authorized with special access rights to such systems, and are required to keep the information confidential. After a transaction, your private information (credit cards, social security numbers, financials, etc.) is never kept on file. We cannot, however, ensure or warrant the absolute security of any information you transmit to us or guarantee that your information on the Service may not be accessed, disclosed, altered, or destroyed by a breach of any of our physical, technical, or managerial safeguards.

Governing Law 
The laws of India, excluding its conflicts of law rules, shall govern this Agreement and your use of our service. Your use of our service may also be subject to other local, state, national, or international laws.

Your Consent
 By using our service, registering an account, or making a purchase, you consent to this Privacy Policy.

Links to Other Websites
This Privacy Policy applies only to the Services. The Services may contain links to other websites not operated or controlled by Vibeus. We are not responsible for the content, accuracy or opinions expressed in such websites, and such websites are not investigated, monitored or checked for accuracy or completeness by us. Please remember that when you use a link to go from the Services to another website, our Privacy Policy is no longer in effect. You’re browsing and interaction on any other website, including those that have a link on our platform, is subject to that website's own rules and policies. Such third parties may use their own cookies or other methods to collect information about you.

Cookies
We use "Cookies" to identify the areas of our website that you have visited. A Cookie is a small piece of data stored on your computer or mobile device by your web browser. We use Cookies to personalize the Content that you see on our website. Most web browsers can be set to disable the use of Cookies. However, if you disable Cookies, you may not be able to access functionality on our website correctly or at all. We never place Personally Identifiable Information in Cookies. 

Advertising
Advertising keeps us and many of the websites and services you use free of charge We work hard to make sure that ads are safe, unobtrusive, and as relevant as possible.

Cookies for Advertising
Cookies help to make advertising more effective Without cookies, it's really hard for an advertiser to reach its audience, or to know how many ads were shown and how many clicks they received. 

Remarketing Services
We use remarketing services. What is Remarketing? In digital marketing, remarketing (or retargeting) is the practice of serving ads across the internet to people who have already Visited your website It allows your company to seem like they're "following" people around the internet by serving ads on the websites and platforms they use most. 

Kids' Privacy 
We do not address anyone under the age of 18. We do not knowingly collect personally identifiable information from anyone under the age of 18. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 18 without verification of parental consent, we take steps to remove that information from our servers. 

Changes to Our Privacy Policy 
If we decide to change our privacy policy, we will post those changes on this page, and/or update the Privacy Policy modification date below.

Third-Party Services 
We may display, include or make available third-party content (including data, information, applications and other products services) or provide links to third-party websites or services ("Third- Party Services").
You acknowledge and agree that we shall not be responsible for any Third-Party Services, including their accuracy, completeness, timeliness, validity, copyright compliance, legality, decency, quality or any other aspect thereof. We do not assume and shall not have any liability or responsibility to you or any other person or entity for any Third-Party Services. 
Third-Party Services and links thereto are provided solely as a convenience to you and you access and use them entirely at your own risk and subject to such third parties' terms and conditions. 



Facebook Pixel 
Facebook pixel is an analytics tool that allows you to measure the effectiveness of your advertising by understanding the actions people take on your website. You can use the pixel to: Make sure your ads are shown to the right people. Facebook pixel may collect information from your device when you use the service. Facebook pixel collects information that is held in accordance with its Privacy Policy. 

Tracking Technologies 
•Google Maps APIs
Google Maps API is a robust tool that can be used to create a custom map, a searchable map, check-in functions, display live data synching with location, plan routes, or create a mashup just to name a few.
Google Maps API may collect information from You and from Your Device for security purposes.
Google Maps API collects information that is held in accordance with its Privacy Policy.

Information about General Data Protection Regulation (GDPR) 
We may be collecting and using information from you if you are from the European Economic Area (EEA), and in this section of our Privacy Policy we are going to explain exactly how and why is this data collected, and how we maintain this data under protection from being replicated or used in the wrong way.

What is GDPR? 
GDPR is an EU-wide privacy and data protection law that regulates how EU residents' data is protected by companies and enhances the control the EU residents have, over their personal data. 

What is personal data? 
Any data that relates to an identifiable or identified individual. GDPR covers a broad spectrum of information that could be used on its own, or in combination with other pieces of information, to identify a person. Personal data extends beyond a person's name or email address. Some examples include financial information, political opinions, genetic data, biometric data, IP addresses, physical address, sexual orientation, and ethnicity. The Data Protection Principles include requirements such as: 
• Personal data collected must be processed in a fair, legal, and transparent way and should only be used in a way that a person would reasonably expect. 
• Personal data should only be collected to fulfil a specific purpose and it should only be used for that purpose. Organizations must specify why they need the personal data when they collect it. 
• Personal data should be held no longer than necessary to fulfil its purpose. 
•People covered by the GDPR have the right to access their own personal data. They can also request a copy of their data, and that their data be updated, deleted, restricted, or moved to another organization. 

Why is GDPR important?
GDPR adds some new requirements regarding how companies should protect individuals' personal data that they collect and process. It also raises the stakes for compliance by increasing enforcement and imposing greater fines for breach. Beyond these facts it's simply the right thing to do. At Help Scout we strongly believe that your data privacy is very important and we already have solid security and privacy practices in place that go beyond the requirements of this new regulation.

Individual Data Subject's Rights - Data Access, Portability and Deletion
We are committed to helping our customers meet the data subject rights requirements of GDPR. We process or store all personal data in fully vetted, DPA compliant vendors. We do store all conversation and personal data for up to 6 years unless your account is deleted. In which case, we dispose of all data in accordance with our Terms of Service and Privacy Policy, but we will not hold it longer than 60 days. 
We are aware that if you are working with EU customers, you need to be able to provide them with the ability to access, update, retrieve and remove personal data. We got you! We've been set up as self-service from the start and have always given you access to your data and your customers data. Our customer support team is here for you to answer any questions you might have about working with the API. 

California Residents
The California Consumer Privacy Act (CCPA) requires us to disclose categories of Personal Information we collect and how we use it. the categories of sources from whom we collect Personal Information, and the third parties with whom we share it, which we have explained above.
We are also required to communicate information about rights California residents have under California law You may exercise the following rights
• Right to Know and Access You may submit a verifiable request for information regarding the (1) categories of Personal Information we collect, use, or share (2) purposes for which categories of Personal information are collected or used by us, (3) categories of sources from which we collect Personal Information and (4) specific pieces of Personal information we have collected about you 
• Right to Equal service. We will not discriminate against you if you exercise your privacy rights. 
• Right to Delete. You may submit a verifiable request to close your account and we will delete Personal Information about you that we have collected. 
• Request that a business that sells a consumer's personal data, not sell the consumer's personal data. 
If you make a request, we have one month to respond to you If you would like to exercise any of these rights, please contact us. 
We do not sell the Personal Information of our users.
For more information about these rights, please contact us. 

California Online Privacy Protection Act (CalOPPA) 
CalOPPA requires us to disclose categories of Personal Information we collect and how we use it, the categories of sources from whom we collect Personal Information, and the third parties with whom we share it, which we have explained above.
 CalOPPA users have the following rights:
• Right to Know and Access. You may submit a verifiable request for information regarding the: (1) categories of Personal Information we collect, use, or share; (2) purposes for which categories of Personal Information are collected or used by us: (3) categories of sources from which we collect Personal Information; and (4) specific pieces of Personal Information we have collected about you.   • Right to Equal Service. We will not discriminate against you if you exercise your privacy rights.        • Right to Delete. You may submit a verifiable request to close your account and we will delete Personal Information about you that we have collected.                                                                                   • Right to request that a business that sells a consumer's personal data, not sell the consumer's personal data.                                                                                                                                                             
If you make a request, we have one month to respond to you. If you would like to exercise any of these rights, please contact us.
We do not sell the Personal Information of our users. For more information about these rights, please contact us. 

Contact Us 
Don't hesitate to contact us if you have any questions.                                                                                      • Via Email: teamvibeus@gmail.com
""",
              style: TextStyle(
                color: Colors.black,
              ),
              linkStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}

class TermsandConditon extends StatefulWidget {
  @override
  _TermsandConditonState createState() => _TermsandConditonState();
}

class _TermsandConditonState extends State<TermsandConditon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          "Terms & Conditions",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Linkify(
              onOpen: (link) async {
                await launch(link.url);
                print(link);
              },
              text: """
Terms & Conditions 
Updated at 10-1-2021 

General Terms
By accessing and placing an order with, you confirm that you are in agreement with and bound by the terms of service contained in the Terms & Conditions outlined below. These terms apply to the entire website and any email or other type of communication between you and 
Under no circumstances shall team be liable for any direct, indirect, special, incidental or consequential damages, including, but not limited to, loss of data or profit, arising out of the use, or the inability to use, the materials on this site, even if team or an authorized representative has been advised of the possibility of such damages. If your use of materials from this site results in the need for servicing, repair or correction of equipment or data, you assume any costs thereof. 
will not be responsible for any outcome that may occur during the course of usage of our resources. We reserve the rights to change prices and revise the resources usage policy in any moment.

License 
Vibeus grants you a revocable, non-exclusive, non- transferable, limited license to download, install and use our service strictly in accordance with the terms of this Agreement. 
These Terms & Conditions are a contract between you and Vibeus (referred to in these Terms & Conditions as "Vibeus", "us", "we" or "our"), the provider of the Vibeus website and the services accessible from the Vibeus website (which are collectively referred to in these Terms & Conditions as the "Vibeus Service"). 
You are agreeing to be bound by these Terms & Conditions. If you do not agree to these Terms & Conditions, please do not use the Service, In these Terms & Conditions, "you" refers both to you as an individual and to the entity you represent. If you violate any of these Terms & Conditions, we reserve the right to cancel your account or block access to your account without notice. 
Definitions and key terms 
For this Terms & Conditions:

• Cookie: small amount of data generated by a website and saved by your web browser. It is used to identify your browser, provide analytics, remember information about you such as your language preference or login information. 
• Company: when this policy mentions "Company," "we," "us," or "our," it refers to Vibeus that is responsible for your information under this Privacy Policy. 
• Country: where Vibeus or the owners/founders of Vibeus are based, in this case is India. 
• Customer: refers to the company, organization or person that signs up to use the Vibeus Service to manage the relationships with your consumers or service users. 
• Device: any internet connected device such as a phone, tablet, computer or any other device that can be used to visit Vibeus and use the services. 
• IP address: Every device connected to the Internet is assigned a number known as an Internet protocol (IP) address. These numbers are usually assigned in geographic blocks. An IP address can often be used to identify the location from which a device is connecting to the Internet. 
• Personnel: refers to those individuals who are employed by Vibeus or are under contract to perform a service on behalf of one of the parties. 
• Personal Data: any information that directly, indirectly, or in connection with other information - including a personal identification number - allows for the identification or identifiability of a natural person. 
• Service: refers to the service provided by Vibeus as described in the relative terms (if available) and on this platform. 
• Third-party service: refers to advertisers, contest sponsors, promotional and marketing partners, and others who provide our content or whose products or services we think may interest you.  
• You: a person or entity that is registered with Vibeus to use the Services.

Restrictions 
You agree not to, and you will not permit others to: 
• License, sell, rent, lease, assign, distribute, transmit, host, outsource, disclose or otherwise commercially exploit the service or make the platform available to any third party. 
• Modify, make derivative works of, disassemble, decrypt, reverse compile or reverse engineer any part of the service. 
• Remove, alter or obscure any proprietary notice (including any notice of copyright or trademark) of or its affiliates, partners, suppliers or the licensors of the service. 

Return and Refund Policy 
Thanks for shopping with us. We appreciate the fact that you like to buy the stuff we build. We also want to make sure you have a rewarding experience while you're exploring, evaluating, and purchasing our products.                                                                                                                                         As with any shopping experience, there are terms and conditions that apply to transactions at our company. We'll be as brief as our attorneys will allow. The main thing to remember is that by placing an order or making a purchase from us, you agree to the terms along with our Privacy Policy.                        If, for any reason, you are not completely satisfied with any good or service that we provide, don't hesitate to contact us and we will discuss any of the issues you are going through with our product.
Your Suggestions 
Any feedback, comments, ideas, improvements or suggestions (collectively. "Suggestions") provided by you to us with respect to the service shall remain the sole and exclusive property of us. We shall be free to use, copy, modify, publish, or redistribute the Suggestions for any purpose and in any way without any credit or any compensation to you. 

Your Consent 
We've updated our Terms & Conditions to provide you with complete transparency into what is being set when you visit our site and how it's being used. By using our service, registering an account, or making a purchase, you hereby consent to our Terms & Conditions. 

Links to Other Websites 
Our service may contain links to other websites that are not operated by Us. If You click on a third-party link, you will be directed to that third party's site. We strongly advise You to review the Terms & Conditions of every site You visit. We have no control over and assume no responsibility for the content, Terms & Conditions or practices of any third-party sites or services.

Cookies 
We use "Cookies" to identify the areas of our website that you have visited. A Cookie is a small piece of data stored on your computer or mobile device by your web browser. We use Cookies to enhance the performance and functionality of our service but are non- essential to their use. However, without these cookies, certain functionality like videos may become unavailable or you would be required to enter your login details every time you visit our platform as we would not be able to remember that you had logged in previously. Most web browsers can be set to disable the use of Cookies. However, if you disable Cookies, you may not be able to access functionality on our website correctly or at all. We never place Personally Identifiable Information in Cookies.

Changes to Our Terms & Conditions 
You acknowledge and agree that we may stop (permanently or temporarily) providing the Service (or any features within the Service) to you or to users generally at our sole discretion, without prior notice to you. You may stop using the Service at any time. You do not need to specifically inform us when you stop using the Service. You acknowledge and agree that if we disable access to your account, you may be prevented from accessing the Service, your account details or any files or other materials which is contained in your account. If we decide to change our Terms & Conditions, we will post those changes on this page, and/or update the Terms & Conditions modification date below.

Modifications to Our service 
We reserve the right to modify, suspend or discontinue, temporarily or permanently, the service or any service to which it connects, with or without notice and without liability to you. 

Updates to Our service 
We may from time to time provide enhancements or improvements to the features/ functionality of the service, which may include patches, bug fixes, updates, upgrades and other modifications ("Updates"). Updates may modify or delete certain features and/or functionalities of the service. You agree that we have no obligation to (i) provide any Updates, or (ii) continue to provide or enable any particular features and/or functionalities of the service to you. You further agree that all Updates will be (i) deemed to constitute an integral part of the service, and (ii) subject to the terms and conditions of this Agreement. 

Third-Party Services 
We may display, include or make available third-party content (including data, information, applications and other products services) or provide links to third-party websites or services ("Third- Party Services"). You acknowledge and agree that we shall not be responsible for any Third-Party Services, including their accuracy, completeness, timeliness, validity, copyright compliance, legality, decency, quality or any other aspect thereof. We do not assume and shall not have any liability or responsibility to you or any other person or entity for any Third-Party Services. Third-Party Services and links thereto are provided solely as a convenience to you and you access and use them entirely at your own risk and subject to such third parties' terms and conditions.

Term and Termination 
This Agreement shall remain in effect until terminated by you or us. We may, in its sole discretion, at any time and for any or no reason, suspend or terminate this Agreement with or without prior notice. This Agreement will terminate immediately, without prior notice from us, in the event that you fail to comply with any provision of this Agreement. You may also terminate this Agreement by deleting the service and all copies thereof from your computer. Upon termination of this Agreement, you shall c6ase all use of the service and delete all copies of the service from your computer. Termination of this Agreement will not limit any of our rights or remedies at law or in equity in case of breach by you (during the term of this Agreement) of any of your obligations under the present Agreement. 



Term and Termination
If you are a copyright owner or such owner's agent and believe any material from us constitutes an infringement on your copyright, please contact us setting forth the following information: (a) a physical or electronic signature of the copyright owner or a person authorized to act on his behalf; (b) identification of the material that is claimed to be infringing: (c) your contact information, including your address, telephone number, and an email; (d) a statement by you that you have a good faith belief that use of the material is not authorized by the copyright owners; and (e) the a statement that the information in the notification is accurate, and, under penalty of perjury you are authorized to act on behalf of the owner.

Indemnification 
You agree to indemnify and hold us and our parents, subsidiaries, affiliates, officers, employees, agents, partners and licensors (if any) harmless from any claim or demand, including reasonable attorneys' fees, due to or arising out of your: (a) use of the service; (b) violation of this Agreement or any law or regulation; or (c) violation of any right of a third party.

No Warranties  
The service is provided to you "AS IS" and "AS AVAILABLE" and with all faults and defects without warranty of any kind. To the maximum extent permitted under applicable law, we, on our own behalf and on behalf of our affiliates and our respective licensors and service providers, expressly disclaims all warranties, whether express, implied, statutory or otherwise, with respect to the service, including all implied warranties of merchantability, fitness for a particular purpose, title and non- infringement, and warranties that may arise out of course of dealing, course of performance, usage or trade practice. Without limitation to the foregoing, we provide no warranty or undertaking, and makes no representation of any kind that the service will meet your requirements, achieve any intended results, be compatible or work with any other software, websites, systems or services, operate without interruption, meet any performance or reliability standards or be error free or that any errors or defects can or will be corrected.                                                                                               
Without limiting the foregoing. neither us nor any provider makes any representation or warranty of any kind, express or implied: (i) as to the operation or availability of the service, or the information, content, and materials or products included thereon; (ii) that the service will be uninterrupted or error-free; (ii) as to the accuracy, reliability, or currency of any information or content provided through the service; or (iv) that the service, its servers, the content, or e-mails sent from or on behalf of us are free of viruses, scripts, trojan horses, worms, malware, timebombs or other harmful components. Some jurisdictions do not allow the exclusion of or limitations on implied warranties or the limitations on the applicable statutory rights of a consumer, so some or all of the above exclusions and limitations may not apply to you.



Limitation of Liability 
Notwithstanding any damages that you might incur, the entire liability of us and any of our suppliers under any provision of this Agreement and your exclusive remedy for all of the foregoing shall be limited to the amount actually paid by you for the service. To the maximum extent permitted by applicable law, in no event shall we or our suppliers be liable for any special, incidental, indirect, or consequential damages whatsoever (including, but not limited to, damages for loss of profits, for loss of data or other information, for business interruption, for personal injury, for loss of privacy arising out of or in any way related to the use of or inability to use the service, third-party software and/or third-party hardware used with the service, or otherwise in connection with any provision of this Agreement), even if we or any supplier has been advised of the possibility of such damages and even if the remedy fails of its essential purpose. Some states/jurisdictions do not allow the exclusion or limitation of incidental or consequential damages, so the above limitation or exclusion may not apply to you.

Severability 
If any provision of this Agreement is held to be unenforceable or invalid, such provision will be changed and interpreted to accomplish the objectives of such provision to the greatest extent possible under applicable law and the remaining provisions will continue in full force and effect. 
This Agreement, together with the Privacy Policy and any other legal notices published by us on the Services, shall constitute the entire agreement between you and us concerning the Services. If any provision of this Agreement is deemed invalid by a court of competent jurisdiction, the invalidity of such provision shall not affect the validity of the remaining provisions of this Agreement, which shall remain in full force and effect. No waiver of any term of this Agreement shall be deemed a further or continuing waiver of such term or any other term, and our failure to assert any right or provision under this Agreement shall not constitute a waiver of such right or provision. YOU AND US AGREE THAT ANY CAUSE OF ACTION ARISING OUT OF OR RELATED TO THE SERVICES MUST COMMENCE WITHIN ONE (1) YEAR AFTER THE CAUSE OF ACTION ACCRUES, OTHERWISE, SUCH CAUSE OF ACTION IS PERMANENTLY BARRED.

Waiver 
Except as provided herein, the failure to exercise a right or to require performance of an obligation under this Agreement shall not affect a party's ability to exercise such right or require such performance at any time thereafter nor shall be the waiver of a breach constitute waiver of any subsequent breach.
No failure to exercise, and no delay in exercising, on the part of either party, any right or any power under this Agreement shall operate as a waiver of that right or power. Nor shall any single or partial exercise of any right or power under this Agreement preclude further exercise of that or any other right granted herein, In the event of a conflict between this Agreement and any applicable purchase or other terms, the terms of this Agreement shall govern.

Amendments to this Agreement 
We reserve the right, at its sole discretion, to modify or replace this Agreement at any time. If a revision is material, we will provide at least 30 days' notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion. By continuing to access or use our service after any revisions become effective, you agree to be bound by the revised terms, if you do not agree to the new terms, you are no longer authorized to use our service.

Entire Agreement 
The agreement constitutes the entire agreement between you and us regarding your use of the service and supersedes all prior contemporaneous written or oral agreements between you and us. You may be subject to additional terms and conditions that apply when you use or purchase other services from us, which we will provide to you at the time of such use or purchase. 

Updates to Our Terms 
We may change our Service and policies, and we may need to make changes to these Terms so that they accurately reflect our Service and policies. Unless otherwise required by law, we will notify you (for example, through our Service) before we make changes to these Terms and give you an opportunity to review them before they go into effect. Then, if you continue to use the Service, you will be bound by the updated Terms. If you do not want to agree to these or any updated Terms, you can delete your account. 

Intellectual Property 
Our platform and its entire contents, features and functionality (including but not limited to all information, software, text, displays, images, video and audio, and the design, selection and arrangement thereof), are owned by us, its licensors or other providers of such material and are protected by and international copyright, trademark, patent, trade secret and other intellectual property or proprietary rights laws. The material may not be copied, modified, reproduced, downloaded or distributed in any way, in whole or in part, without the express prior written permission of us, unless and except as is expressly provided in these Terms & Conditions, any unauthorized use of the material is prohibited.

Agreement to Arbitrate 
This section applies to any dispute EXCEPT IT DOESN'T INCLUDE A DISPUTE RELATING TO CLAIMS FOR INJUNCTIVE OR EQUITABLE RELIEF REGARDING THE ENFORCEMENT OR VALIDITY OF YOUR OR Vibeus's INTELLECTUAL PROPERTY RIGHTS. The term "dispute" means any dispute, action, or other controversy between you and us concerning the Services or this agreement, whether in contract, warranty, tort, statute, regulation, ordinance, or any other legal or equitable basis. "Dispute" will be given the broadest possible meaning allowable under law. 

Notice of Dispute 
In the event of a dispute, you or us must give the other a Notice of Dispute, which is a written statement that sets forth the name, address, and contact information of the party giving it, the facts giving rise to the dispute, and the relief requested. You must send any Notice of Dispute via email to: We will send any Notice of Dispute to you by mail to your address if we have it, or otherwise to your email address. You and us will attempt to resolve any dispute through informal negotiation within sixty (60) days from the date the Notice of Dispute is sent. After sixty (60) days, you or us may commence arbitration. 

Binding Arbitration
If you and us don't resolve any dispute by informal negotiation, any other effort to resolve the dispute will be conducted exclusively by binding arbitration as described in this section. You are giving up the right to litigate (or participate in as a party or class member) all disputes in court before a judge or jury. The dispute shall be settled by binding arbitration in accordance with the commercial arbitration rules of the American Arbitration Association. Either party may seek any interim or preliminary injunctive relief from any court of competent jurisdiction, as necessary to protect the party's rights or property pending the completion of arbitration. Any and all legal, accounting, and other costs, fees, and expenses incurred by the prevailing party shall be borne by the non-prevailing party.

Submissions and Privacy 
In the event that you submit or post any ideas, creative suggestions, designs, photographs, information, advertisements, data or proposals, including ideas for new or improved products, services, features, technologies or promotions, you expressly agree that such submissions will automatically be treated as non- confidential and non-proprietary and will become the sole property of us without any compensation or credit to you whatsoever. We and our affiliates shall have o obligations with respect to such submissions or posts and may use the ideas contained in such submissions or posts for any purposes in any medium in perpetuity. including, but not limited to, developing, manufacturing, and marketing products and services using such ideas.

Promotions
We may, from time to time, include contests, promotions, sweepstakes, or other activities ("Promotions") that require you to submit material or information concerning yourself, please note that all Promotions may be governed by separate rules that may contain certain eligibility requirements, such as restrictions as to age and geographic location. You are responsible to read all Promotions rules to determine whether or not you are eligible to participate. If you enter any Promotion, you agree to abide by and to comply with all Promotions Rules. Additional terms and conditions may apply to purchases of goods or services on or through the Services, which terms and conditions are made a part of this Agreement by this reference. 

Typographical Errors 
In the event a product and/or service is listed at an incorrect price or with incorrect information due to typographical error, we shall have the right to refuse or cancel any orders placed for the product and/ or service listed at the incorrect price. We shall have the right to refuse or cancel any such order whether or not the order has been confirmed and your credit card charged. if your credit card has already been charged for the purchase and your order is cancelled, we shall immediately issue a credit to your credit card account or other payment account in the amount of the charge.

Miscellaneous 
If for any reason a court of competent jurisdiction finds any provision or portion of these Terms & Conditions to be unenforceable, the remainder of these Terms & Conditions will continue in full force and effect. Any waiver of any provision of these Terms & Conditions will be effective only if in writing and signed by an authorized representative of us. We will be entitled to injunctive or other equitable relief (without the obligations of posting any bond or surety) in the event of any breach or anticipatory breach by you. We operate and control our Service from our offices in. The Service is not intended for distribution to or use by any person or entity in any jurisdiction or country where such distribution or use would be contrary to law or regulation. Accordingly, those persons who choose to access our Service from other locations do so on their own initiative and are solely responsible for compliance with local laws, if and to the extent local laws are applicable. These Terms & Conditions (which include and incorporate our Privacy Policy) contains the entire understanding, and supersedes all prior understandings, between you and us concerning its subject matter, and cannot be changed or modified by you. The section headings used in this Agreement are for convenience only and will not be given any legal import.

Disclaimer 
We are not responsible for any content, code or any other imprecision. We do not provide warranties or guarantees. In no event shall we be liable for any special, direct, indirect, consequential, or incidental damages or any damages whatsoever whether in an action of contract, negligence or other tort, arising out of or in connection with the use of the Service or the contents of the Service. We reserve the right to make additions, deletions, or modifications to the contents on the Service at any time without prior notice.
Our Service and its contents are provided "as is" and "as available" without any warranty or representations of any kind, whether express or implied. We are a distributor and not a publisher of the content supplied by third parties; as such, our exercises no editorial control over such content and makes no warranty or representation as to the accuracy, reliability or currency of any information, content, service or merchandise provided through or accessible via our Service. Without limiting the foregoing, we specifically disclaim all warranties and representations in any content transmitted on or in connection with our Service or on sites that may appear as links on our Service, or in the products provided as a part of, or otherwise in connection with, our Service, including without limitation any warranties of merchantability, fitness for a particular purpose or non-infringement of third-party rights. No oral advice or written information given by us or any of its affiliates, employees, officers, directors, agents, or the like will create a warranty. Price and availability information is subject to change without notice. Without limiting the foregoing, we do not warrant that our Service will be uninterrupted, uncorrupted, timely, or error-free.

Contact Us 
Don't hesitate to contact us if you have any questions.
• Via Email: teamvibeus@gmail.com                                                                              
""",
              style: TextStyle(
                color: Colors.black,
              ),
              linkStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}

class ComunityGuidlines extends StatefulWidget {
  @override
  _ComunityGuidlinesState createState() => _ComunityGuidlinesState();
}

class _ComunityGuidlinesState extends State<ComunityGuidlines> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          "Community Guidelines",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Linkify(
              onOpen: (link) async {
                await launch(link.url);
                print(link);
              },
              text: """
Community Guidelines
We expect everyone on Vibeus to treat each other respectfully, with kindness and compassion. We do not tolerate hateful, hurtful, or harassing content on Vibeus.  We consider unsolicited sexual content and messages to be sexual harassment. We don't like jerks, so please don't be a jerk. 
Here's the thing. We want you to think about this one rule: treat online interactions as you would even if they were offline. 
•	When sending messages, consider what you would say to someone who you just met at a club or coffee shop. 
•	When uploading photos, consider if the same pose or outfit would be appropriate in public. 
•	When creating a profile, consider if you'd feel comfortable having a family member or friend read it. 
Vibeus is not a place where people want to hear about your sexual fantasies out of the blue, or where you can be mean to someone with no repercussions. Treat it as a place where you can talk to other humans about things that matter to you both, and remember that the best way to make a meaningful connection with someone is to treat them well.

Below are our community guidelines and moderation standards. If you see anyone who violates these guidelines, please report them right away teamvibes@gmail.com 
In this article:
Harassment
If you wouldn’t say it to someone you just met in person, you shouldn’t be saying it online. Messages should be respectful, appropriate, honest, and kind. We don't tolerate "negging" (insulting statements disguised as "flirting") or other rude behaviour. This expectation also includes interactions with Vibeus staff. People found to be sending harassing messages will be banned.
Additionally, profile content itself should also be respectful and kind. Profile essays which are found to be overly combative or hateful may be removed or may even result in your profile being banned.
Sexual Harassment/ Explicit Sexual Content
Exposing other people to your sexual fantasies without their consent is rude and inappropriate, and it's not what most people on Vibeus are looking for. If your profile is reported to us as sexually explicit or offensive, it will be banned. This includes kink/ fetish profiles, profiles describing which sex acts they are looking for, etc. 
We also do not allow unwanted sexually explicit messages on Vibeus. This includes descriptions of sexual acts/ kinks/ fetishes, sexualized comments about people's photos, etc.  Even if someone says they are open to hook-ups on their profile, it does NOT mean they want sexually explicit messages.
Finally, we do not allow sexually explicit photos or nudity.
We consider this to be sexual harassment and will ban any offenders that are reported to us.
Hate
We take the truth of everyone’s inalienable rights very seriously. Our belief in them has acted as our inspiration since our founding. We proudly stand rooted in inclusivity. There is no room for hate in a place where you’re looking for love. 
Any content (including in profiles and messages) that promotes or condones racism, bigotry, violence, hate, dehumanization, or harm against individuals or groups based on things like race, ethnicity, disability, age, nationality, sexual orientation, gender, gender identity, religion, appearance, or occupation/association with a group is strictly forbidden and may result in you being permanently banned. This includes but is not limited to:
•	Symbols of hate groups in photos, racist or offensive memes, etc.
•	Hateful slurs, offensive statements, coded language, dog whistles, or references to being a member of a hate group
•	Giving approval (even tacit) or statements of support towards a hate group or their ideals
•	It also includes your reports to Vibeus staff: if you flag a profile for no other reason than being trans, for example, it may result in your own profile being banned.
Violent or Graphic Content
We do not allow any content in photos, profiles, or messages that is threatening, incites violence, contains graphic or gratuitous violence or gore, or is disturbing or otherwise inappropriate for a dating site. This does also include depictions of self-harm which can in turn be harmful for others to see. This content will be removed and may also get you banned.  
Profile names and profile text
We consider your profile's display name and your profile text to be similar to a first message or first impression to other members of the site: we expect both to be respectful and appropriate. If your profile text or name could be seen as offensive, hateful, obscene, or clearly trolling, we will take moderation action, up to and including banning your profile.

Your listed name should be the name you like to go by. It can be your first name, your initials, or a nickname- all are fine. It does not have to be the full name on your birth certificate! We do not check listed names against any kind of ID, and we trust people to enter names they'd like to go by themselves. That said, we will still moderate based on names if they include offensive or obscene language, or make a profile appear to be fake (i.e., using a celebrity name instead of your own).
Unique and bona fide profile
You must create only one unique profile. In addition, your use of Vibeus must be for bona fide relationship-seeking purposes (for example, you may not use Vibeus solely to compile a report of compatible singles in your area, to find people to join a club or group activity, or to write a school research paper).
Additionally, deleting and re-creating your account to get around other member's Passes or Blocks of you is not acceptable. If we see excessive and suspicious account deletion activity, we may ban your profile. 
Fake Accounts
We do not tolerate any kind of fake accounts on Vibeus. Your profile must be really of you, and must be for dating purposes.
Creating a fake account will get your main account as well as the fake account(s) banned. 

Also, your profile details such as age, height, location, etc. must be accurate. We restrict searching and showing profiles based on mutual fit for details like age, location, gender, and orientation for a reason: so that you can find a person who is looking for someone just like you. Changing these details to appear in searches that you would not otherwise is not allowed and will result in your profile being banned.  
Couples/ Joint accounts
We do not allow joint accounts or couples accounts. If you want to use Vibeus with your partner for non-monogamous dating, that's cool! However, you'll want to link accounts with your partner instead of having one joint account. 
•	If you are in a relationship and are dating outside of that relationship without your partner's consent and/or without disclosing your relationship status, that is a violation of our community guidelines and will get your profile banned. 
Solicitation
Using Vibeus for commercial solicitation or exchange of money is prohibited. Do not share your own financial information (PayPal, Venmo, Amazon Wishlist, etc.) for the purpose of receiving money or goods from other members. Do not attempt to get other member's financial or other private information.  
Do not send messages or create accounts for the purpose of driving members to a business or external site. This includes recruiting people for a hobby or activity if it's not for dating purposes. 

We also do not allow references to sugar daddy/baby dating, asking for gifts to date, wanting to be \$poiled, etc, or phrases like "Send me \$5 and see what happens" on your profile. This all falls under solicitation of money/goods and is not allowed. 
Likewise, we also do not allow offers of money for sex, sugar daddies, acceptance of solicitation offers, etc. 
Doing any of these will get you banned.
Contact information 
We do not allow anyone to post private information for public display, including their own private information, but especially other people's. Violations of other people's privacy will result in a ban.
It's always good to be cautious when exchanging contact info. A sign of a scammer, fake account, or someone up to no good is when they are in a hurry to give you their offsite contact info too quickly. This could be because they want to get you away from Vibeus so they can continue talking with you even after we ban them, or they are sharing someone else's contact info to get revenge on them. 
Don’t give your phone number out too quickly - If you keep communication on the dating site, then you are much more protected. If the user is discovered to be a scammer or has other bad reports against them then you may see the profile disappear quickly-- this is likely because we've banned them. If a user vanishes and re-appears under another name, that is a very very bad sign. We ban people for good reasons. If you have given them your phone number or email address too quickly then you won’t see if we have banned them.
If something seems strange about the way someone is exchanging contact info, or if they are displaying a phone number or email address prominently on their profile or photos, please report. 
Illegal behaviour
It should go without saying, but discussion or promotion of anything illegal is not allowed and will result in getting you banned. This includes illegal sexual acts, drug dealing, fraud, threats, or anything else that is against the law. We do not tolerate any kind of discussion about underage sex, including dd/lg fantasies.
Minors/ under 18
You must be 18 to use Vibeus. We do not allow minors to use Vibeus. Although all profiles only allow you to enter an age over 18, sometimes people will lie about their age. If you suspect a profile of being made by someone who is under 18, please report them to us. 

If we find someone to be knowingly engaging in inappropriate conversation with someone who has revealed themselves to be under 18, we will also ban that profile. 
Photos
A more detailed list of photo rules:
•	Photos should include your face (profile photo album), or be pictures you've taken (elsewhere). 
•	We do not allow any photos with nudity or explicitly sexual content.
•	We also do not allow any hateful imagery (white power/ Nazi images, racist meme photos, etc). This will get you banned. Any photos of anything overly violent, offensive, illegal, disturbing, or otherwise inappropriate for a dating site will be removed and may also get you banned.  
•	Photos with contact information on them (including phone number, email address, kik, Facebook address, etc) will be removed. Repeated violation of this rule or other suspicious behaviour may result in the profile being blocked as well. 
•	Photos of you as a kid, or of your kids but without you in the photo as well will be removed.
•	Finally, we will remove any image where the copyright holder has asked to have it removed, or where we strongly suspect the user is not the copyright holder (e.g., stock photos). 
•	For multiple offenses or extreme cases, profiles may also be banned and removed.
If a photo is removed you will be emailed and told that this has happened and warned that repeated offenses might get you banned. This warning isn't a fake one, and we will ban your account for multiple infractions.
Offsite behaviour
We do ban for extreme offsite behaviour. Please report any instances of offsite abuse, assault, harassment, stalking, theft, or anything else illegal or that makes you feel unsafe. (Note: we will not tell the person you're reporting to us that you have reported them or why they were reported).
In these cases, we encourage you to reach out to law enforcement as well, who we will cooperate with where needed.  
A final note:
While our community guidelines cover most instances of moderator action, it is not an exhaustive list, and we do retain the right to ban anyone from Vibeus for any reason if we see fit.                                                                    
""",
              style: TextStyle(
                color: Colors.black,
              ),
              linkStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}


