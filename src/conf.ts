import YQ from './yq/yq';
import Video from './video';
export default class ConfigMgr {
    arrowStr: string = 'arrow';
    prizeStr: string = 'prize';
    video:Video | null = null;

    loadConf() {
        YQ.get('data.json', null, (data: XMLHttpRequest | null, status: number) => {
            const strNoData: string = '未能成功获取配置数据 ';
            if (status != 200) {
                alert(strNoData + status.toString());
                return;
            }
            if (data == null) {
                alert(strNoData);
                return;
            }
            const textData: string = data.responseText;
            if (textData.length < 10) {
                alert(strNoData);
                return;
            }
            const json: object = JSON.parse(textData);
            window.g_confdata = json;
            this.loadMedia();
            this.video = new Video();
            this.showTitle();
            this.showList();
            this.exconf();
        });
    }

    showTitle() {
        const title: string = window.g_confdata.title;
        document.title = title;
        const titleDiv: HTMLDivElement = YQ.divById('title');
        titleDiv.innerText = title;
    }

    loadMedia() {
        const audioEle: HTMLAudioElement = document.createElement('audio');
        audioEle.id = "bgm";
        audioEle.src = window.g_confdata.se_audio;
        audioEle.preload = "auto";
        audioEle.loop = true;
        const videoEle: HTMLVideoElement = document.createElement('video');
        videoEle.id = 'bgvideo'
        videoEle.autoplay = true;
        videoEle.loop = true;
        videoEle.muted = true;
        const videoSrc: HTMLSourceElement = document.createElement('source');
        videoSrc.src = window.g_confdata.bg_video;
        const fileNameUnit: string[] = videoSrc.src.split('.');
        const extname: string = fileNameUnit[fileNameUnit.length - 1];
        videoSrc.type = 'video/' + extname;
        videoEle.appendChild(videoSrc);
        document.body.appendChild(videoEle);
        document.body.appendChild(audioEle);
        window.onresize = () => {
            this.video!.resize();
        }
    }

    shrinkList(prizeNameDiv: HTMLDivElement) {
        const prizeNameDivID: string = prizeNameDiv.id;
        const prizeID: string = prizeNameDivID.substring(prizeNameDivID.length - 1);
        const prizeSubListID: string = this.prizeStr + 'SubList' + prizeID;
        const prizeSubListDiv: HTMLDivElement = YQ.divById(prizeSubListID);

        let iElement: HTMLElement = document.getElementById(prizeNameDiv.id + 'i') as HTMLElement;
        const isHidden: boolean = (iElement.className.indexOf(`${this.arrowStr}Down`) < 0);
        if (isHidden) {
            iElement.className = `${this.arrowStr}i ${this.arrowStr}Down`;
            prizeSubListDiv.style.display = 'block';
            prizeNameDiv.style.color = '#FFFF00';
        } else {
            iElement.className = `${this.arrowStr}i ${this.arrowStr}Right`;
            prizeSubListDiv.style.display = 'none';
            prizeNameDiv.style.color = '#CCC';
        }
    }

    showList() {
        const listDIV: HTMLDivElement = YQ.divById('list');
        const prizes = window.g_confdata.prize;
        let i = 0;
        let lastPrizeName = '';
        for (const key in prizes) {
            const prize: string | number[] = prizes[key];
            const prizeName: string = prize[0] as string;
            const prizeNumber: number = prize[1] as number;
            const prizeNameDiv: HTMLDivElement = document.createElement('div');
            prizeNameDiv.className = this.prizeStr + 'Name';
            prizeNameDiv.id = prizeNameDiv.className + i.toString();
            const shrinkIcon: HTMLElement = document.createElement('i');
            shrinkIcon.className = `${this.arrowStr}i ${this.arrowStr}Down`;
            shrinkIcon.id = prizeNameDiv.className + i.toString() + 'i';
            prizeNameDiv.appendChild(shrinkIcon);
            prizeNameDiv.innerHTML += prizeName;
            lastPrizeName = prizeName;
            prizeNameDiv.addEventListener('click', () => {
                this.shrinkList(prizeNameDiv);
            });
            listDIV.appendChild(prizeNameDiv);
            const prizeNowList: HTMLDivElement = document.createElement('div');
            prizeNowList.className = this.prizeStr + 'SubList';
            prizeNowList.id = prizeNowList.className + i.toString();
            for (let j = 0; j < prizeNumber; j++) {
                const prizeUserDiv: HTMLDivElement = document.createElement('div');
                prizeUserDiv.className = this.prizeStr + 'User';
                prizeUserDiv.id = prizeUserDiv.className + j.toString();
                prizeUserDiv.className += ' t' + prizeNameDiv.id;
                prizeUserDiv.innerText = '尚未揭晓';
                prizeNowList.appendChild(prizeUserDiv);
            }
            listDIV.appendChild(prizeNowList);
            i++;
        }
        if (lastPrizeName.length > 0) {
            YQ.divById('prize').innerText = lastPrizeName;
        }
    }

    exconf() {
        const showList: HTMLElement = document.getElementById('showList') as HTMLElement;
        if ('publiclist' in window.g_confdata && window.g_confdata.publiclist == 0) {
            showList.innerHTML = '';
            showList.style.display = 'none';
        }
        const showCode: HTMLElement = document.getElementById('showCode') as HTMLElement;
        if ('githublink' in window.g_confdata && window.g_confdata.githublink == 0) {
            showCode.innerHTML = '';
            showCode.style.display = 'none';
        }
    }
}