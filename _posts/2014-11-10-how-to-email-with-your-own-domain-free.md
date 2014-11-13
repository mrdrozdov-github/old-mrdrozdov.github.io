---
layout: post
title: "How to email with your own domain -- free!"
description: ""
category: protip
tags: [email, gmail, mailgun]
---
{% include JB/setup %}

We'll setup an email address so that you can receive and send messages from youruser@yourdomain.com through yourotheruser@gmail.com.

# Step 1: Creating and Verifying a Domain in Mailgun

In Mailgun, go to Domains > Add New Domain and enter yourdomain.com. You should see three sections: "Add DNS records for sending", "Add DNS records for tracking", and "Add DNS records for receiving (optional)". 

In Namecheap, go to Manage Domains and select your domain, then select All Host Records. First, go to the Mail Settings section and select User (it defaults to Free Email Forwarding). Save changes and some more input fields should appear. Now, we'll go through the sections from Mailgun one part at a time.

### Add DNS records for sending

In the Sub-Domain Settings, we'll be adding two rows of Record Type TXT. For one row, we'll want the hostname to be "@", and the other value should be "v=spf1 include:mailgun.org ~all". For the second row, we'll want the hostname to be something like mx._domainkey or whichever value Mailgun provides. The matching value for this hostname should be taken from Mailgun.

### Add DNS records for tracking

In the Sub-Domain Settings, we'll be adding one row of Record Type CNAME. The hostname should be email and the other value should be mailgun.org.

### Add DNS records for receiving (optional)

In the Mail Settings, we'll add two rows. The hostname should be "@" in both cases, and the other value should be taken from Mailgun. The MX Pref should be 10.

### Verification

Now let's go to your Domains in Mailgun, select the appropriate domain, and the click Check DNS Records Now. Hopefully everything checks out and we'll be good to go! DNS records do take some time to propogate so give Mailgun sometime if it doesn't work right away.

# Step 2: Forward Emails to Gmail

This is super easy, and we'll use Mailgun routes. Create a new route with the filter expression match_recipient("youruser@domain.com"), and an action forward("yourotheruser@gmail.com"). You may need to go back to your domains, Manage SMTP Credentials, and add youruser with SOME_PASSWORD. That's it!

# Step 3: Send Emails from Gmail

In Gmail, go to Settings > Accounts and Import > Send Mail As > Add Another Email Address You Own. Put in youruser@yourdomain.com, uncheck treat as Alias (otherwise your actual Gmail account will show up in emails), then next. Get your SMPT Server from Mailgun (should be something like smtp.mailgun.org), put in SOME_PASSWORD, and just use the default port and connection type. Save changes.

# Done!

You should now be able to send and receives emails in Gmail as youruser@yourdomain.com. You may want to check your Spam folder in the beginning, but Gmail should adjust quickly.
