<?php

If (IsSet($_GET['browse']))
  $directory = RealPath($_GET['browse']);
Else
  $directory = RealPath(ABSPATH);
  
$arr_folder = Array();
$arr_file = Array();
ForEach (Glob($directory . '/*', GLOB_MARK) AS $object){
  If (Is_Dir($object)) $arr_folder[] = RealPath($object);
  If (Is_File($object)) $arr_file[] = RealPath($object);
}
?>
<script type="text/javascript">
var folder_deletion_confirmation = "<?php Echo $this->t('Are you sure you want to delete this folder?') ?>";
var file_deletion_confirmation = "<?php Echo $this->t('Are you sure you want to delete this file?') ?>";
</script>

<div class="file-commander-interface">

<?php If (IsSet($_GET['message'])) : ?>
<div id="message" class="updated fade">
<p>
  <strong><?php Echo StripSlashes($_GET['message']); ?></strong>
</p>
</div>
<?php EndIf; ?>

<div class="workdir">
 <?php Echo $this->t('You are here') ?> &raquo; <i><?php Echo $directory ?></i>
</div>

<?php If (RealPath($directory . '/..')) : ?>
<div class="upwards">
  <a href="<?php Echo $this->interface_url(Array('browse' => RealPath($directory . '/..'))) ?>"><?php Echo $this->t('&uArr; Upward') ?></a>
</div>
<?php EndIf; ?>

<?php If(!Empty($arr_folder)) : ?>
<h3><?php Echo $this->t('Folders') ?></h3>
<?php EndIf; ?>
<?php ForEach ($arr_folder AS $folder) : // Display Folders ?>
  <div class="folder">
    <a href="<?php Echo $this->interface_url(Array('browse' => $folder)) ?>"><?php Echo BaseName($folder) ?></a>
    <div class="operation">
      <?php If($this->get_option('user_can_rename_folder')) : ?>
      <div class="rename hidden"><a href="#" title="<?php Echo $this->t('Rename') ?>"><?php Echo $this->t('Rename') ?></a></div>
      <?php EndIf; If($this->get_option('user_can_delete_folder')) : ?>
      <div class="delete"><a href="<?php Echo $this->interface_url(Array('delete_folder' => $folder)) ?>" title="<?php Echo $this->t('Delete') ?>"><?php Echo $this->t('Delete') ?></a></div>
      <?php EndIf; If ($this->get_http_link($folder)) : ?>
      <div class="view"><a href="<?php Echo $this->get_http_link($folder) ?>" title="<?php Echo $this->t('View in Browser') ?>"><?php Echo $this->t('View in Browser') ?></a></div>
      <?php EndIf; ?>
    </div>
    <?php If($this->get_option('user_can_rename_folder')) : ?>
    <div class="rename-form hide-if-js">
      <form method="post" action="<?php Echo $this->interface_url() ?>">
        <input type="hidden" name="action" value="rename_folder" />
        <input type="hidden" name="directory" value="<?php Echo HTMLSpecialChars($directory) ?>" />
        <input type="hidden" name="old_name" value="<?php Echo HTMLSpecialChars(BaseName($folder)) ?>" />
        <?php Echo $this->t('New name for this folder') ?>:
        <input type="text" name="new_name" value="<?php Echo HTMLSpecialChars(BaseName($folder)) ?>" />
        <input type="submit" value="<?php Echo $this->t('Rename') ?>" />
      </form>
    </div>
    <?php EndIf; ?>
  </div>
<?php EndForEach; ?>
<?php If ($this->get_option('user_can_create_folder')) : ?>
<h3><?php Echo $this->t('Create folder') ?></h3>
<form method="post" action="<?php Echo $this->interface_url() ?>">
  <input type="hidden" name="action" value="create_folder" />
  <input type="hidden" name="directory" value="<?php Echo HTMLSpecialChars($directory) ?>" />
  <?php Echo $this->t('Name of the new folder') ?>:
  <input type="text" name="new_folder" value="" />
  <input type="submit" value="<?php Echo $this->t('Create') ?>" />
</form>
<?php EndIf; ?>


<?php If(!Empty($arr_file)) : ?>
<h3><?php Echo $this->t('Files') ?></h3>
<?php EndIf; ?>
<?php ForEach ($arr_file AS $file) : // Display Files ?>
  <div class="file">
    <?php If ($this->get_http_link($file)) : ?>
      <a href="<?php Echo $this->get_http_link($file) ?>"><?php Echo BaseName($file) ?></a>
    <?php Else : ?>
      <?php Echo BaseName($file) ?>
    <?php EndIf; ?>
    <?php If($this->get_option('user_can_see_file_size')) : ?>
      <small>- <?php Echo $this->Format_Bytes(FileSize($file)) ?> -</small>
    <?php EndIf; ?>    
    <?php If($this->get_option('user_can_see_mtime')) : ?>
      <small>(<?php Echo Date($this->t('F d Y H:i:s', 'Dateformat for the file modification time.'), FileMTime($file)) ?>)</small>
    <?php EndIf; ?>    
    <div class="operation">
      <?php If($this->get_option('user_can_rename_file')) : ?>
      <div class="rename hidden"><a href="#" title="<?php Echo $this->t('Rename') ?>"><?php Echo $this->t('Rename') ?></a></div>
      <?php EndIf; If($this->get_option('user_can_delete_file')) : ?>
      <div class="delete"><a href="<?php Echo $this->interface_url(Array('delete_file' => $file)) ?>" title="<?php Echo $this->t('Delete') ?>"><?php Echo $this->t('Delete') ?></a></div>
      <?php EndIf; If ($this->get_http_link($file)) : ?>
      <div class="view"><a href="<?php Echo $this->get_http_link($file) ?>" title="<?php Echo $this->t('View in Browser') ?>"><?php Echo $this->t('View in Browser') ?></a></div>
      <?php EndIf; If ($this->get_option('user_can_download_file')) : ?>
      <div class="download"><a href="<?php Echo $this->interface_url(Array('download_file' => $file)) ?>" title="<?php Echo $this->t('Download') ?>"><?php Echo $this->t('Download') ?></a></div>
      <?php EndIf; ?>
    </div>
    <?php If($this->get_option('user_can_rename_file')) : ?>
    <div class="rename-form hide-if-js">
      <form method="post" action="<?php Echo $this->interface_url() ?>">
        <input type="hidden" name="action" value="rename_file" />
        <input type="hidden" name="directory" value="<?php Echo HTMLSpecialChars($directory) ?>" />
        <input type="hidden" name="old_name" value="<?php Echo HTMLSpecialChars(BaseName($file)) ?>" />
        <?php Echo $this->t('New name for this file') ?>:
        <input type="text" name="new_name" value="<?php Echo HTMLSpecialChars(BaseName($file)) ?>" />
        <input type="submit" value="<?php Echo $this->t('Rename') ?>" />
      </form>
    </div>
    <?php EndIf; ?>
  </div>
<?php EndForEach; ?>
<?php If ($this->get_option('user_can_upload_file')) : ?>
<h3><?php Echo $this->t('Upload file') ?></h3>
<form method="post" action="<?php Echo $this->interface_url() ?>" enctype="multipart/form-data">
  <input type="hidden" name="action" value="upload_file" />
  <input type="hidden" name="directory" value="<?php Echo HTMLSpecialChars($directory) ?>" />  
  <div class="file_upload">
    <?php Echo $this->t('Please choose a file') ?>:
    <input type="file" name="file_upload[]" value="" />
  </div>
  <p><small><?php Echo $this->t('All already existing files will be overwritten!') ?></small></p>
  <input type="submit" value="<?php Echo $this->t('Upload') ?>" />
</form>
<?php EndIf; ?>

</div><!-- End of File Commander Interface Wrapper -->
