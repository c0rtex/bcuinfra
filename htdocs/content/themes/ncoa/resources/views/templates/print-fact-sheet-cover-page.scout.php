<div style="page-break-before: auto;">
@extends('layouts.print')
@section('main')

  <div class="print-cover">

    <div class="print-cover-top">
      <h1>Your BenefitsCheckUp Report</h1>
      <p>Brought to you by</p>
      <img class="print-cover-logo-bcu" src="<?php echo themosis_assets() ?>/images/BCU-logo.jpg" alt="BenefitsCheckUp">
      <img class="print-cover-logo-ncoa" src="<?php echo themosis_assets() ?>/images/ncoa-logo.png" alt="National Council on Aging">
    </div>

    <div class="print-cover-intro">
      <h2>Introduction</h2>
      <p>BenefitsCheckUp has prepared the following report identifying benefits programs for you to consider. Many of these programs will help you save money on health care, prescriptions, utilities, food assistance, and other services. For your convenience, this report includes program details such as: program descriptions, application forms, local contact information that answers questions and helps with enrollment, and a listing of necessary documentation to aid in the application process.</p>
      <p><em>It is important to note that final program eligibility determination can only be made by the agencies administering the program(s). We encourage you to contact the agencies with any questions you may have.</em></p>
    </div>

    <div class="print-cover-toc">
      <h2>Table of Contents</h2>
      <ul class="leaders">
        <li class="leader-section"><span class="title">Medication</span> <span class="nums">1</span></li>
        <li><span class="title">FamilyWize Prescription Savings Program</span> <span class="nums">1</span></li>
        <li class="leader-section"><span class="title">Health Care</span> <span class="nums">3</span></li>
        <li><span class="title">Medicaid Spend-down/Medically Needy Spend-down Program</span> <span class="nums">3</span></li>
        <li><span class="title">EyeCare America's Online Referral Center</span> <span class="nums">5</span></li>
        <li class="leader-section"><span class="title">Income Assistance</span> <span class="nums">7</span></li>
        <li><span class="title">Supplemental Security Income</span> <span class="nums">7</span></li>
        <li class="leader-section"><span class="title">Food & Nutrition</span> <span class="nums">9</span></li>
        <li><span class="title">Supplemental Nutrition Assistance Program (SNAP)</span> <span class="nums">9</span></li>
        <li><span class="title">Elderly Nutrition Program - Congregate or Group Meals</span> <span class="nums">11</span></li>
        <li><span class="title">Elderly Nutrition Program - Home Delivered Meals</span> <span class="nums">13</span></li>
        <li><span class="title">Commodity Supplemental Food Program (CSFP)</span> <span class="nums">15</span></li>
        <li><span class="title">Senior Farmers' Market Nutrition Program</span> <span class="nums">17</span></li>
        <li><span class="title">The Emergency Food Assistance Program (TEFAP)</span> <span class="nums">19</span></li>
        <li class="leader-section"><span class="title">Housing & Utilities</span> <span class="nums">21</span></li>
        <li><span class="title">HUD Public Housing Program</span> <span class="nums">21</span></li>
        <li><span class="title">Housing Choice Vouchers (Section 8) Program</span> <span class="nums">23</span></li>
        <li><span class="title">Weatherization Assistance Program</span> <span class="nums">25</span></li>
        <li><span class="title">Lifeline</span> <span class="nums">27</span></li>
        <li><span class="title">SafeLink Wireless®</span> <span class="nums">29</span></li>
        <li><span class="title">Assurance Wireless®</span> <span class="nums">31</span></li>
        <li class="leader-section"><span class="title">Tax Relief</span> <span class="nums">33</span></li>
        <li><span class="title">Tax Credit for the Elderly and Disabled</span> <span class="nums">33</span></li>
        <li><span class="title">Retirement Income Exemption from Taxation</span> <span class="nums">35</span></li>
        <li class="leader-section"><span class="title">Discount</span> <span class="nums">37</span></li>
        <li><span class="title">America the Beautiful - Senior Pass</span> <span class="nums">37</span></li>
      </ul>
    </div>

  </div>

</div>

@stop