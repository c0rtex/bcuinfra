<h3><?php Echo $this->t('Required user level') ?></h3>
<p>
<?php Echo $this->t('User level') ?>:
<input type="text" name="min_user_level" value="<?php Echo $this->get_option('min_user_level') ?>" size="3" />
<small>(<?php Echo $this->t('This is the minimum securitiy level a user has to have to use the file commander.') ?>)</small>
</p>


<h3><?php Echo $this->t('Enable functions') ?></h3>
<p>
<input type="checkbox" name="user_can_create_folder" value="yes" <?php Checked ($this->get_option('user_can_create_folder'), 'yes') ?>/>            
<?php Echo $this->t('User can create folders.') ?>
</p>

<p>
<input type="checkbox" name="user_can_rename_folder" value="yes" <?php Checked ($this->get_option('user_can_rename_folder'), 'yes') ?>/>            
<?php Echo $this->t('User can rename folders.') ?>
</p>

<p>
<input type="checkbox" name="user_can_delete_folder" value="yes" <?php Checked ($this->get_option('user_can_delete_folder'), 'yes') ?>/>            
<?php Echo $this->t('User can delete folders.') ?>
</p>

<p>
<input type="checkbox" name="user_can_upload_file" value="yes" <?php Checked ($this->get_option('user_can_upload_file'), 'yes') ?>/>            
<?php Echo $this->t('User can upload files.') ?>
</p>

<p>
<input type="checkbox" name="user_can_download_file" value="yes" <?php Checked ($this->get_option('user_can_download_file'), 'yes') ?>/>            
<?php Echo $this->t('User can download files.') ?>
</p>

<p>
<input type="checkbox" name="user_can_rename_file" value="yes" <?php Checked ($this->get_option('user_can_rename_file'), 'yes') ?>/>            
<?php Echo $this->t('User can rename files.') ?>
</p>

<p>
<input type="checkbox" name="user_can_delete_file" value="yes" <?php Checked ($this->get_option('user_can_delete_file'), 'yes') ?>/>            
<?php Echo $this->t('User can delete files.') ?>
</p>

<p>
<input type="checkbox" name="user_can_see_mtime" value="yes" <?php Checked ($this->get_option('user_can_see_mtime'), 'yes') ?>/>            
<?php Echo $this->t('User can see the modification time of files.') ?>
</p>

<p>
<input type="checkbox" name="user_can_see_file_size" value="yes" <?php Checked ($this->get_option('user_can_see_file_size'), 'yes') ?>/>            
<?php Echo $this->t('User can see the file size.') ?>
</p>
