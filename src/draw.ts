import NyaDom from "./libNyaruko_TS/nyadom";
import NyaAs from "./libNyaruko_TS/nyaas";
export default class Draw {
    audioEnable: boolean = true;
    audioScratch: boolean = true;

    prizeUsers: HTMLDivElement[] = [];
    prizeUserStr: string = 'prizeUser';
    prizeUserNowDiv: HTMLDivElement | null = null;
    btnStart: HTMLButtonElement;
    btnStartStr: string = 'btnStart';
    names: string[] = [];
    timer: number | null = null;
    nameDiv: HTMLDivElement;
    isComplete = false;
    prizeNameDiv: HTMLDivElement;
    audio: HTMLAudioElement | null = null;
    showList: HTMLLinkElement;
    undo: HTMLLinkElement;
    btnStartBox: HTMLDivElement;

    constructor() {
        this.nameDiv = NyaAs.div(NyaDom.byId('name'));
        this.prizeNameDiv = NyaAs.div(NyaDom.byId('prize'));
        this.btnStartBox = NyaAs.div(NyaDom.byId('btnStartBox'));
        this.btnStart = document.getElementById(this.btnStartStr) as HTMLButtonElement;
        this.btnStart.addEventListener('click', () => {
            this.btnStartClick();
        });
        this.showList = document.getElementById('showList') as HTMLLinkElement;
        if (this.showList.style.display != 'none') {
            this.showList.addEventListener('click', () => {
                this.btnShowListClick();
            });
        }
        this.undo = document.getElementById('undo') as HTMLLinkElement;
        if (this.undo.style.display != 'none') {
            this.undo.addEventListener('click', () => {
                this.btnUndoClick();
            });
        }
        this.startBtnEnable(false);
    }

    btnStartClick() {
        if (this.isComplete) {
            this.complete(true);
            return;
        }
        if (this.timer == null) {
            this.start();
        } else {
            this.end();
        }
    }

    btnShowListClick() {
        this.getNames();
        const nameList: HTMLDivElement = NyaAs.div(NyaDom.byId('nameList'));
        nameList.style.display = 'inline-block';
        if (nameList.innerText.length == 0) {
            let html: string = `<p>${this.showList.innerText}</p><hr/>`;
            for (const name of this.names) {
                html += `<span>${name}</span>`;
            }
            if (this.names.length % 2 != 0) {
                html += `<span>&emsp;</span>`;
            }
            nameList.innerHTML = html;
        }
        nameList.addEventListener('click', () => {
            nameList.style.display = 'none';
        });
    }

    getPrizeUsers() {
        if (this.prizeUsers.length == 0) {
            const prizeUserDivs: HTMLCollectionOf<Element> = document.getElementsByClassName(this.prizeUserStr);
            const prizeUserDivsArr: Element[] = Array.from(prizeUserDivs);
            for (const key in prizeUserDivsArr) {
                const prizeUser: HTMLDivElement = prizeUserDivs[key] as HTMLDivElement;
                this.prizeUsers.unshift(prizeUser);
            }
        }
    }

    getNames() {
        if (this.names.length == 0) {
            this.names = window.g_confdata.list;
        }
    }

    startBtnEnable(isWorking: boolean) {
        if (isWorking) {
            this.btnStart.className = `${this.btnStartStr} ${this.btnStartStr}W`;
            this.btnStart.innerText = '停止!';
        } else {
            this.btnStart.className = `${this.btnStartStr} ${this.btnStartStr}N`;
            this.btnStart.innerText = '开始抽选';
        }
    }

    start() {
        this.getNames();
        this.getPrizeUsers();
        const can = this.nameLocation();
        if (!can) {
            return;
        }
        this.startBtnEnable(true);
        if (this.audioEnable) {
            if (!this.audio) {
                this.audio = document.getElementById('bgm') as HTMLAudioElement;
            }
            this.audio.play();
        }
        this.timer = self.setInterval(() => {
            this.timerI(this);
        }, 10);
    }

    nameLocation(): boolean {
        let can = false;
        for (const key in this.prizeUsers) {
            const prizeUser: HTMLDivElement = this.prizeUsers[key];
            const prizeUserClass: string = prizeUser.className;
            if (prizeUserClass.indexOf(this.prizeUserStr + 'OK') >= 0) {
                continue;
            }
            can = true;
            prizeUser.className += ` ${this.prizeUserStr}Now`;
            prizeUser.innerHTML = '正在揭晓...';
            this.prizeUserNowDiv = prizeUser;
            let prizeDivID: string = prizeUser.classList[1];
            prizeDivID = prizeDivID.substring(1);
            const nowPrizeNameDiv: HTMLDivElement = NyaAs.div(NyaDom.byId(prizeDivID));
            this.prizeNameDiv.innerText = nowPrizeNameDiv.innerText;
            break;
        }
        return can;
    }

    chkCanNext() {
        let can = false;
        if (this.names.length > 0) {
            for (const key in this.prizeUsers) {
                const prizeUser: HTMLDivElement = this.prizeUsers[key];
                const prizeUserClass: string = prizeUser.className;
                if (prizeUserClass.indexOf(this.prizeUserStr + 'OK') >= 0) {
                    continue;
                }
                can = true;
                break;
            }
        }
        if (!can) {
            this.complete(false);
        }
    }

    complete(isShowComplete: boolean) {
        this.btnStart.className = `${this.btnStartStr} ${this.btnStartStr}X`;
        this.btnStart.innerText = '确认最终结果';
        this.isComplete = true;
        if (isShowComplete) {
            NyaAs.div(NyaDom.byId('prizeing')).innerText = '';
            this.prizeNameDiv.innerHTML = '抽奖结束';
            this.nameDiv.innerText = '恭喜中奖者';
            NyaAs.div(NyaDom.byId('btnStartBox')).style.display = 'none';
        }
    }

    randomName() {
        const random: number = Math.random() * this.names.length;
        const key: number = Math.floor(random);
        const item: string = this.names[key];
        return item;
    }

    timerI(that: this) {
        that.nameDiv.innerText = that.randomName();
    }

    end() {
        if (this.audioEnable) {
            this.audio!.pause();
            if (this.audioScratch) {
                this.audio!.currentTime = 0;
            }
        }
        window.clearInterval(this.timer as number);
        this.timer = null;
        const winName: string = this.randomName();
        for (let i = 0; i < this.names.length; i++) {
            const name: string = this.names[i];
            if (name == winName) {
                this.names.splice(i, 1);
                break;
            }
        }
        this.nameDiv.innerText = winName;
        this.prizeUserNowDiv!.className = this.prizeUserNowDiv!.className.replace(this.prizeUserStr + 'Now', this.prizeUserStr + 'OK');
        this.prizeUserNowDiv!.innerText = winName;
        this.startBtnEnable(false);
        this.chkCanNext();
    }

    btnUndoClick() {
        const prizeUserOK: string = ' prizeUserOK';
        // 倒序搜尋列表中已有姓名的元素
        for (let i = this.prizeUsers.length - 1; i >= 0; i--) {
            // for (let i = 0; i < this.prizeUsers.length; i++) {
            const prizeUser: HTMLDivElement = this.prizeUsers[i];
            if (prizeUser.className.indexOf(prizeUserOK) != -1) {
                prizeUser.className = prizeUser.className.replace(prizeUserOK, '');
                this.prizeNameDiv.innerText = this.prizeUser2PrizeName(prizeUser) ?? '';
                this.nameDiv.innerText = prizeUser.innerText = '尚未揭晓';
                break;
            }
        }
    }

    prizeUser2PrizeName(prizeUser: HTMLDivElement): string | null {
        const classList: string[] = prizeUser.className.split(' ');
        for (const nClassName of classList) {
            if (nClassName.indexOf('tprizeName') != -1) {
                const prizeNameId: string = nClassName.substring(1);
                const prizeNameDivN: HTMLDivElement = NyaAs.div(NyaDom.byId(prizeNameId));
                const nowPrizeName: string = prizeNameDivN.innerText;
                return nowPrizeName;
            }
        }
        return null;
    }

    keyboard(key: string) {
        if (this.btnStartBox.style.display == 'none') {
            return;
        }
        switch (key) {
            case 'Enter':
                if (this.btnStart.style.display != 'none') {
                    this.btnStartClick();
                }
                break;
            case 'l':
                if (this.showList.style.display != 'none') {
                    this.btnShowListClick();
                }
                break;
            case 'u':
                if (this.undo.style.display != 'none') {
                    this.btnUndoClick();
                }
                break;
            default:
                break;
        }
    }
}