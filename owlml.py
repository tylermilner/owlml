import cv2
import numpy as np

def findTemplate(template, img):
    img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    w, h = template.shape[::-1]

    res = cv2.matchTemplate(img_gray, template, cv2.TM_CCOEFF_NORMED)
    threshold = 0.8
    loc = np.where( res >= threshold)

    for pt in zip(*loc[::-1]):
        cv2.rectangle(img, pt, (pt[0] + w, pt[1] + h), (0,255,255), 1)

# img_rgb = cv2.imread('Images/Template Matching/frame_grab_cropped.png')
img_rgb = cv2.imread('Images/Template Matching/frame_grab_cropped-2.png')

lucioTemplate = cv2.imread('Images/Template Matching/lucio.png', 0)
reinhardtTemplate = cv2.imread('Images/Template Matching/reinhardt.png', 0)
zaryaTemplate = cv2.imread('Images/Template Matching/zarya.png', 0)
zenyattaTemplate = cv2.imread('Images/Template Matching/zenyatta.png', 0)

findTemplate(lucioTemplate, img_rgb)
findTemplate(reinhardtTemplate, img_rgb)
findTemplate(zaryaTemplate, img_rgb)
findTemplate(zenyattaTemplate, img_rgb)

cv2.imshow('Detected', img_rgb)
cv2.waitKey()
