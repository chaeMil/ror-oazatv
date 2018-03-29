var JsRoutesRails = (function() {
  var routes = {};
  
  routes['convert_admin_archive_item_archive_file_path'] = function(options) {
    return format('/admin/archive_items/:archive_item_id/archive_files/:id/convert', options);
  };
  
  routes['admin_archive_item_archive_files_path'] = function(options) {
    return format('/admin/archive_items/:archive_item_id/archive_files', options);
  };
  
  routes['new_admin_archive_item_archive_file_path'] = function(options) {
    return format('/admin/archive_items/:archive_item_id/archive_files/new', options);
  };
  
  routes['edit_admin_archive_item_archive_file_path'] = function(options) {
    return format('/admin/archive_items/:archive_item_id/archive_files/:id/edit', options);
  };
  
  routes['admin_archive_item_archive_file_path'] = function(options) {
    return format('/admin/archive_items/:archive_item_id/archive_files/:id', options);
  };
  
  routes['admin_archive_items_path'] = function(options) {
    return format('/admin/archive_items', options);
  };
  
  routes['new_admin_archive_item_path'] = function(options) {
    return format('/admin/archive_items/new', options);
  };
  
  routes['edit_admin_archive_item_path'] = function(options) {
    return format('/admin/archive_items/:id/edit', options);
  };
  
  routes['admin_archive_item_path'] = function(options) {
    return format('/admin/archive_items/:id', options);
  };
  
  routes['status_admin_video_queue_item_path'] = function(options) {
    return format('/admin/video_queue_items/:id/status', options);
  };
  

  function format(string, options) {
    var str = string.toString();
    for (var option in options) {
      str = str.replace(RegExp("\\:" + option, "gi"), options[option]);
    }

    return str;
  };

  return routes;
})();
