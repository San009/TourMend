<?php

use PHPMailer\PHPMailer\PHPMailer;

$mail = new PHPMailer(true);

//SMTP settings
$mail->isSMTP();
$mail->Host = "smtp.gmail.com";
$mail->SMTPAuth = true;
$mail->Username = "kailashkandel2@gmail.com";
$mail->Password = "TourMend@123";
$mail->Port = 465; //587 for tls
$mail->SMTPSecure = "ssl"; //next option is tls

// email settings
$mail->isHTML(true);
$mail->setFrom($sender, "TourMend App");
$mail->addAddress($email);
$mail->Subject = $subject;
$mail->Body = $body;
