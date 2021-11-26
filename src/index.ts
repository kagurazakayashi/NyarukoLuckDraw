import ConfigMgr from './conf';
import Draw from './draw';

window.onload = () => {
    const conf = new ConfigMgr();
    conf.loadConf();
    const draw = new Draw();
}