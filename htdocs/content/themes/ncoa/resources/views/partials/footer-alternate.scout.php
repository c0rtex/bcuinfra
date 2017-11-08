<div class="container">
    <div class="row">
        <div class="col-sm-12">
            <div class="super-footer super-footer--alternate">
                <div class="super-footer-inner">
                    <span class="super-footer-copyright">
                        &copy; <?php echo date("Y"); ?> National Council on Aging.
                    </span>
                    <span class="super-footer-link"><a href="/privacy-policy">Privacy Policy</a></span>
                    <span class="super-footer-spacer">|</span>
                    <span class="super-footer-link"><a href="/terms-of-use/">Terms of Use</a></span>
                    @if($_SESSION['partner_id']==0)
                    <span class="super-footer-spacer">|</span>
                    <span class="super-footer-link"><a href="mailto:comments@benefitscheckup.org">Feedback</a></span>
                    <span class="super-footer-spacer">|</span>
                    <span class="super-footer-link"><a href="/partner-login/">Login</a></span>
                    @endif
                </div>
            </div>
        </div>
    </div>
</div>
