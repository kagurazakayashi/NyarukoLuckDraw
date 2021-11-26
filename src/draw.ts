import YQ from './yq/yq';
export default class Draw {
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

    constructor() {
        this.nameDiv = YQ.divById('name');
        this.prizeNameDiv = YQ.divById('prize');
        this.btnStart = document.getElementById(this.btnStartStr) as HTMLButtonElement;
        this.btnStart.addEventListener('click', () => {
            if (this.isComplete) {
                this.complete(true);
                return;
            }
            if (this.timer == null) {
                this.start();
            } else {
                this.end();
            }
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
            const nowPrizeNameDiv: HTMLDivElement = YQ.divById(prizeDivID);
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

    complete(isShowComplete:boolean) {
        this.btnStart.className = `${this.btnStartStr} ${this.btnStartStr}X`;
        this.btnStart.innerText = '抽选结束';
        this.isComplete = true;
        if (isShowComplete) {
            YQ.divById('prizeing').innerText = '';
            this.prizeNameDiv.innerHTML = '恭喜';
            this.nameDiv.innerText = '所有中奖者';
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
}