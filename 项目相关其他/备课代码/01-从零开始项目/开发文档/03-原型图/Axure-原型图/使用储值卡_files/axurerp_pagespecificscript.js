﻿for(var i = 0; i < 10; i++) { var scriptId = 'u' + i; window[scriptId] = document.getElementById(scriptId); }

$axure.eventManager.pageLoad(
function (e) {

});
document.getElementById('u4_img').tabIndex = 0;

u4.style.cursor = 'pointer';
$axure.eventManager.click('u4', function(e) {

if (true) {

	self.location.href=$axure.globalVariableProvider.getLinkUrl('储值卡.html');

}
});
gv_vAlignTable['u5'] = 'center';document.getElementById('u6_img').tabIndex = 0;

u6.style.cursor = 'pointer';
$axure.eventManager.click('u6', function(e) {

if (true) {

	self.location.href=$axure.globalVariableProvider.getLinkUrl('成功.html');

}
});
gv_vAlignTable['u7'] = 'center';gv_vAlignTable['u9'] = 'center';gv_vAlignTable['u1'] = 'center';gv_vAlignTable['u3'] = 'center';