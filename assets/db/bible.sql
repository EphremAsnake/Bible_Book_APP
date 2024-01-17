import CustomTheme from "@/src/configs/theme/themeConfig";
import { singleHotelSelector } from "@/src/features/master_data/hotel/hotelSlice";
import { Hotel } from "@/src/types/models/master_data/hotel";
import { Card, Divider, Grid, Typography } from "@mui/material";
import { Box } from "@mui/system";
import { useSelector } from "react-redux";

export default function HotelDetail() {
    let hotel: Hotel = useSelector(singleHotelSelector);
    return (
        <Card className="shadow-sm font-light" elevation={0} sx={{ mt: 2 }}>
            <Box sx={{ display: "flex", justifyContent: "space-between", mt: 2, }}>
                <Card className="shadow-sm font-light" elevation={0}>
                    <Box sx={{ m: 2 }}>
                        <Typography
                            variant="body2"
                            color={CustomTheme.palette.secondary.main}
                        >
                            BASIC INFORMATION
                        </Typography>
                        <Divider sx={{ my: 1 }} />
                        <Box
                            sx={{
                                display: "flex",
                                flexDirection: "column",
                                justifyContent: "flex-start",
                            }}
                        >
                            <Box
                                sx={{
                                    mt: 4,
                                    display: "flex",
                                    flexDirection: "row",
                                    gap: 2
                                }}
                            >
                                <Typography
                                    variant="body2"
                                    fontWeight={"bold"}
                                    color={CustomTheme.palette.secondary.main}
                                >
                                    Name:
                                </Typography>

                                <Typography variant="body2">
                                    {hotel.name}
                                </Typography>
                            </Box>
                            <Box
                                sx={{
                                    mt: 4,
                                    display: "flex",
                                    flexDirection: "row",
                                    gap: 2
                                }}
                            >
                                <Typography
                                    variant="body2"
                                    fontWeight={"bold"}
                                    color={CustomTheme.palette.secondary.main}
                                >
                                    Address:
                                </Typography>

                                <Typography variant="body2">
                                    {hotel.address}
                                </Typography>
                            </Box>


                        </Box>

                        <Box
                            sx={{
                                display: "flex",
                                flexDirection: "column",
                                justifyContent: "flex-start",
                                
                            }}
                        >
                            <Box
                                sx={{
                                    mt: 4,
                                    display: "flex",
                                    flexDirection: "row",

                                    gap: 2
                                }}
                            >
                                <Typography
                                    variant="body2"
                                    fontWeight={"bold"}
                                    color={CustomTheme.palette.secondary.main}
                                >
                                    Email:
                                </Typography>

                                <Typography variant="body2">
                                    {hotel.email}
                                </Typography>
                            </Box>

                            <Box
                                sx={{
                                    mt: 4,
                                    display: "flex",
                                    flexDirection: "row",

                                    gap: 2
                                }}
                            >
                                <Typography
                                    variant="body2"
                                    fontWeight={"bold"}
                                    color={CustomTheme.palette.secondary.main}
                                >
                                    Phone Number:
                                </Typography>

                                <Typography variant="body2">
                                    {hotel.phoneNumber}
                                </Typography>
                            </Box>
                            {/* <Box
                                sx={{
                                    mt: 4,
                                    display: "flex",
                                    flexDirection: "row",
                                    justifyContent: "space-around",
                                    gap: 2
                                }}
                            >
                                <Typography
                                    variant="body2"
                                    fontWeight={"bold"}
                                    color={CustomTheme.palette.secondary.main}
                                >
                                    Website :
                                </Typography>

                                <Typography variant="body2">
                                    {hotel.websiteUrl}
                                </Typography>
                            </Box>

                            <Box
                                sx={{
                                    mt: 4,
                                    display: "flex",
                                    flexDirection: "row",
                                    justifyContent: "space-around",
                                    gap: 2
                                }}
                            >
                                <Typography
                                    variant="body2"
                                    fontWeight={"bold"}
                                    color={CustomTheme.palette.secondary.main}
                                >
                                    Rank:
                                </Typography>

                                <Typography variant="body2">
                                    {hotel.rank}
                                </Typography>
                            </Box> */}
                        </Box>
                    </Box>
                </Card>
                <Card className="shadow-sm font-light" elevation={0}>
                    <Box sx={{ m: 2 }}>
                        <Typography
                            variant="body2"
                            color={CustomTheme.palette.secondary.main}
                        >
                            ACCOMMODATION SERVICES
                        </Typography>
                        <Divider sx={{ my: 1 }} />
                        {hotel?.accommodationServices?.map((accommodation, index) =>
                            <Box key={index}>
                                <Grid container alignItems="center" sx={{ mt: 2 }} >
                                    <Grid item>
                                        <Typography variant="body2">Service:</Typography>
                                    </Grid>
                                    <Grid item sx={{ ml: 1 }}>
                                        <Typography variant="body2">
                                            {accommodation.serviceId}
                                        </Typography>
                                    </Grid>
                                </Grid>
                                <Grid container alignItems="center" sx={{ mt: 2 }} >
                                    <Grid item>
                                        <Typography variant="body2">Open Time:</Typography>
                                    </Grid>
                                    <Grid item sx={{ ml: 1 }}>
                                        <Typography variant="body2">
                                            {accommodation.openTime}
                                        </Typography>
                                    </Grid>
                                </Grid>

                                <Grid container alignItems="center" sx={{ mt: 2 }} >
                                    <Grid item>
                                        <Typography variant="body2">Close Time:</Typography>
                                    </Grid>
                                    <Grid item sx={{ ml: 1 }}>
                                        <Typography variant="body2">
                                            {accommodation.closeTime}
                                        </Typography>
                                    </Grid>
                                </Grid>
                            </Box>
                        )}
                    </Box>
                </Card>



            </Box>
            <Box sx={{ display: "flex", justifyContent: "space-around", mt: 4 }}>
                <Card className="shadow-sm font-light" elevation={0}>
                    <Box >
                        <Typography
                            variant="body2"
                            color={CustomTheme.palette.secondary.main}
                        >
                            MEAL TYPE SCHEDULE
                        </Typography>
                        <Divider sx={{ my: 1 }} />
                        {hotel?.mealTypeSchedules?.map((mealType, index) =>
                            <Box key={index}>
                                <Grid container alignItems="center" sx={{ mt: 2 }} >
                                    <Grid item>
                                        <Typography variant="body2">Service:</Typography>
                                    </Grid>
                                    <Grid item sx={{ ml: 1 }}>
                                        <Typography variant="body2">
                                            {mealType.mealTypeId}
                                        </Typography>
                                    </Grid>
                                </Grid>
                                <Grid container alignItems="center" sx={{ mt: 2 }} >
                                    <Grid item>
                                        <Typography variant="body2">Open Time:</Typography>
                                    </Grid>
                                    <Grid item sx={{ ml: 1 }}>
                                        <Typography variant="body2">
                                            {mealType.openTime}
                                        </Typography>
                                    </Grid>
                                </Grid>

                                <Grid container alignItems="center" sx={{ mt: 2 }} >
                                    <Grid item>
                                        <Typography variant="body2">Close Time:</Typography>
                                    </Grid>
                                    <Grid item sx={{ ml: 1 }}>
                                        <Typography variant="body2">
                                            {mealType.closeTime}
                                        </Typography>
                                    </Grid>
                                </Grid>
                            </Box>
                        )}
                    </Box>
                </Card>


                <Card className="shadow-sm font-light" elevation={0}>
                    <Box sx={{ m: 2 }}>
                        <Typography
                            variant="body2"
                            color={CustomTheme.palette.secondary.main}
                        >
                            ROOM TYPES
                        </Typography>
                        <Divider sx={{ my: 1 }} />
                        {hotel?.hotelRoomTypes?.map((roomType, index) =>
                            <Box key={index}>
                                <Grid container alignItems="center" sx={{ mt: 2 }} >
                                    <Grid item>
                                        <Typography variant="body2">Service:</Typography>
                                    </Grid>
                                    <Grid item sx={{ ml: 1 }}>
                                        <Typography variant="body2">
                                            {roomType.roomTypeID}
                                        </Typography>
                                    </Grid>
                                </Grid>
                                <Grid container alignItems="center" sx={{ mt: 2 }} >
                                    <Grid item>
                                        <Typography variant="body2">Capacity:</Typography>
                                    </Grid>
                                    <Grid item sx={{ ml: 1 }}>
                                        <Typography variant="body2">
                                            {roomType.capacity}
                                        </Typography>
                                    </Grid>
                                </Grid>

                                <Grid container alignItems="center" sx={{ mt: 2 }} >
                                    <Grid item>
                                        <Typography variant="body2">Price Per Night:</Typography>
                                    </Grid>
                                    <Grid item sx={{ ml: 1 }}>
                                        <Typography variant="body2">
                                            {roomType.pricePerNight}
                                        </Typography>
                                    </Grid>
                                </Grid>
                            </Box>
                        )}
                    </Box>
                </Card>

                <Card className="shadow-sm font-light" elevation={0}>
                    <Box sx={{ m: 2 }}>
                        <Typography
                            variant="body2"
                            color={CustomTheme.palette.secondary.main}
                        >
                            FACILITIES
                        </Typography>
                        <Divider sx={{ my: 1 }} />
                        {hotel?.hotelFacilities?.map((facilities, index) =>
                            <Box key={index}>
                                <Grid container alignItems="center" sx={{ mt: 2 }} >
                                    <Grid item>
                                        <Typography variant="body2">Service:</Typography>
                                    </Grid>
                                    <Grid item sx={{ ml: 1 }}>
                                        <Typography variant="body2">
                                            {facilities.facilityId}
                                        </Typography>
                                    </Grid>
                                </Grid>
                                <Grid container alignItems="center" sx={{ mt: 2 }} >
                                    <Grid item>
                                        <Typography variant="body2">Open Time:</Typography>
                                    </Grid>
                                    <Grid item sx={{ ml: 1 }}>
                                        <Typography variant="body2">
                                            {facilities.openTime}
                                        </Typography>
                                    </Grid>
                                </Grid>

                                <Grid container alignItems="center" sx={{ mt: 2 }} >
                                    <Grid item>
                                        <Typography variant="body2">Close Time:</Typography>
                                    </Grid>
                                    <Grid item sx={{ ml: 1 }}>
                                        <Typography variant="body2">
                                            {facilities.closeTime}
                                        </Typography>
                                    </Grid>
                                </Grid>
                            </Box>
                        )}
                    </Box>
                </Card>
            </Box>

        </Card>
    );
}

