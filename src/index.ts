import ConfigMgr from './conf';
import Draw from './draw';
import Video from './video';

window.onload = () => {
    if (!!window.ActiveXObject || "ActiveXObject" in window) {
        document.body.innerText = '不能在 IE 或旧版本浏览器下工作，请更换/更新浏览器。';
    }
    const conf = new ConfigMgr();
    conf.loadConf();
    const draw = new Draw();
    document.addEventListener('keyup', function (e) {
        draw.keyboard(e.key);
    });
}