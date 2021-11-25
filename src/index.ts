import ConfigMgr from './conf';

window.onload = () => {
    const conf = new ConfigMgr();
    conf.loadConf();
}