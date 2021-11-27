import ConfigMgr from './conf';
import Draw from './draw';
import Video from './video';

window.onload = () => {
    const conf = new ConfigMgr();
    conf.loadConf();
    const draw = new Draw();
    const video = new Video();
    window.onresize = () => {
        video.resize();
    }
}